import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../core/models/materials/category/material_category_model.dart';
import '../../../../../../core/models/materials/like/material_like_model.dart';
import '../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../core/models/result.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/services/material/material_service.dart';
import '../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../base_screen_args.dart';
import '../../../../base_screen_controller.dart';

final class MaterialListScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Service<MaterialService> _materialService;
  MaterialListScreenController(super.args, this._materialService);

  final Rx<List<MaterialItem>> materials = Rx<List<MaterialItem>>(<MaterialItem>[]);
  final Rx<List<MaterialCategory>> materialsCategories = Rx<List<MaterialCategory>>(<MaterialCategory>[]);
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final Rx<int> selectedIndex = Rx<int>(0);
  final Rx<double> scrollOffset = Rx<double>(0.0);

  final Rx<bool> isLoadingMore = Rx<bool>(false);
  int _currentPage = 1;
  int _totalPages = 1;
  bool _hasMore = true;
  bool _isFetching = false;

  MaterialCategory? _selectedCategory;
  static const int _itemsPerPage = 10;
  Timer? _debounce;
  Rx<String> currentQuery = Rx<String>('');
  Rx<int> totalMaterials = Rx<int>(0);

  @override
  Future<void> onInitState() async {
    super.onInitState();

    _fetchMaterialCategories();
    searchController.addListener(_onSearchChanged);

    scrollController.addListener(() {
      scrollOffset(set: () => scrollController.offset);

      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 && _hasMore) {
        _loadMore();
      }
    });

    await refresh();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (currentQuery.value != searchController.text) {
        currentQuery.value = searchController.text;
        refresh();
      }
    });
  }

  void refreshSearchQuery() {
    searchController.text = '';
    //currentQuery(set: () => '');
  }

  void changeSelectIndex(int index) {
    selectedIndex(set: () => index);
    selectCategory(materialsCategories.value[index]);
  }

  void selectCategory(MaterialCategory? category) {
    if (_selectedCategory?.id != category?.id) {
      _selectedCategory = category;
      refresh();
    }
  }

  Future<void> refresh() async {
    _currentPage = 1;
    _hasMore = true;
    await _fetchMaterials(page: _currentPage);
  }

  void _loadMore() async {
    if (_isFetching || !_hasMore) {
      return;
    }
    await _fetchMaterials(page: _currentPage + 1);
  }

  Future<void> _fetchMaterialCategories() async {
    await _materialService().getMaterialsCategories().then(
      (Result<MaterialCategoriesResponseModel, ApiException> result) {
        result.on(
          success: (MaterialCategoriesResponseModel response) {
            materialsCategories(set: () => response.data.categories);
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );
  }

  Future<void> _fetchMaterials({required int page}) async {
    if (_isFetching) {
      return;
    }

    _isFetching = true;

    if (page > 1) {
      isLoadingMore(set: () => true);
    } else {
      viewState.setBusy(true);
    }

    await _materialService()
        .getMaterials(
          page: page,
          limit: _itemsPerPage,
          query: currentQuery.value.isNotEmpty ? currentQuery.value : null,
          parentCategory: _selectedCategory?.name,
          //category: _selectedCategory?.id,
        )
        .then(
          (Result<MaterialsResponseModel, ApiException> result) {
            result.on(
              success: (MaterialsResponseModel response) {
                final List<MaterialItem> newMaterials = response.data.materials;
                final Pagination pagination = response.data.pagination;

                if (page == 1) {
                  materials(set: () => newMaterials);
                } else {
                  materials(set: () => <MaterialItem>[...materials.value, ...newMaterials]);
                }

                _currentPage = pagination.page;
                _totalPages = pagination.pages;
                _hasMore = _currentPage < _totalPages;
                totalMaterials(set: () => pagination.total);
              },
              failure: (ApiException e) async {
                await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
              },
            );
          },
        );

    if (page > 1) {
      isLoadingMore(set: () => false);
    } else {
      viewState.setBusy(false);
    }
    _isFetching = false;
  }

  Future<void> toggleLike(String materialId) async {
    _updateMaterialLikeStatusOptimistic(materialId);

    await _materialService().updateMaterialLikes(materialId).then(
      (Result<MaterialLikedResponseItem, ApiException> result) {
        result.on(
          success: (MaterialLikedResponseItem response) {
            _updateMaterialLikeStatus(materialId, response.isLiked, response.likeCount);
          },
          failure: (ApiException e) async {
            _revertLikeStatus(materialId);
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );
  }

  void _updateMaterialLikeStatusOptimistic(String materialId) {
    final List<MaterialItem> updatedMaterials = materials.value.map((MaterialItem material) {
      if (material.id == materialId) {
        return material.copyWith(
          isLiked: !(material.isLiked ?? false),
          likeCount: (material.isLiked ?? false) ? material.likeCount ?? 0 - 1 : material.likeCount ?? 0 + 1,
        );
      }
      return material;
    }).toList();

    materials(set: () => updatedMaterials);
  }

  void _updateMaterialLikeStatus(String materialId, bool isLiked, int likeCount) {
    final List<MaterialItem> updatedMaterials = materials.value.map((MaterialItem material) {
      if (material.id == materialId) {
        return material.copyWith(
          isLiked: isLiked,
          likeCount: likeCount,
        );
      }
      return material;
    }).toList();

    materials(set: () => updatedMaterials);
  }

  void _revertLikeStatus(String materialId) {
    final List<MaterialItem> updatedMaterials = materials.value.map((MaterialItem material) {
      if (material.id == materialId) {
        return material.copyWith(
          isLiked: !(material.isLiked ?? false),
          likeCount: (material.isLiked ?? false) ? material.likeCount ?? 0 - 1 : material.likeCount ?? 0 + 1,
        );
      }
      return material;
    }).toList();

    materials(set: () => updatedMaterials);
  }

  @override
  void onDispose() {
    scrollController.dispose();
    searchController.dispose();
    super.onDispose();
  }
}

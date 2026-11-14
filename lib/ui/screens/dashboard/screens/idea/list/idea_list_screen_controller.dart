import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../core/init/app_locator.dart';
import '../../../../../../core/models/idea/list/idea_list_model.dart';
import '../../../../../../core/models/idea/purchase/idea_purchase_response_model.dart';
import '../../../../../../core/models/idea/size_ranges/idea_size_ranges_model.dart';
import '../../../../../../core/models/result.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/routing/app_navigation.dart';
import '../../../../../../core/services/auth/auth_service.dart';
import '../../../../../../core/services/idea/idea_service.dart';
import '../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../base_screen_args.dart';
import '../../../../base_screen_controller.dart';

final class IdeaListScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Service<IdeaService> _ideaService;
  IdeaListScreenController(super.args, this._ideaService);

  final Rx<List<IdeaItem>> ideas = Rx<List<IdeaItem>>(<IdeaItem>[]);
  final Rx<List<SizeRange>> ideasRanges = Rx<List<SizeRange>>(<SizeRange>[]);
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final Rx<int> selectedIndex = Rx<int>(0);
  final Rx<double> scrollOffset = Rx<double>(0.0);

  final Rx<bool> isLoadingMore = Rx<bool>(false);
  int _currentPage = 1;
  int _totalPages = 1;
  bool _hasMore = true;
  bool _isFetching = false;

  SizeRange? _selectedRange;
  static const int _itemsPerPage = 10;
  Timer? _debounce;
  //String _currentQuery = '';
  Rx<String> currentQuery = Rx<String>('');
  Rx<int> totalMaterials = Rx<int>(0);

  @override
  Future<void> onInitState() async {
    super.onInitState();

    _fetchIdeaCategories();
    searchController.addListener(_onSearchChanged);

    scrollController.addListener(() {
      scrollOffset(set: () => scrollController.offset);
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 && _hasMore) {
        _loadMore();
      }
    });

    await refresh();
  }

  @override
  void onDispose() {
    scrollController.dispose();
    searchController.dispose();
    super.onDispose();
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

  void changeSelectIndex(int index) {
    selectedIndex(set: () => index);
    selectCategory(ideasRanges.value[index]);
  }

  void selectCategory(SizeRange? range) {
    if (_selectedRange?.label != range?.label) {
      _selectedRange = range;
      refresh();
    }
  }

  void refreshSearchQuery() {
    searchController.text = '';
  }

  Future<void> refresh() async {
    _currentPage = 1;
    _hasMore = true;
    await _fetchIdeas(page: _currentPage);
  }

  void _loadMore() async {
    if (_isFetching || !_hasMore) {
      return;
    }
    await _fetchIdeas(page: _currentPage + 1);
  }

  Future<void> _fetchIdeaCategories() async {
    await _ideaService().getIdeaSizeRanges().then(
      (Result<IdeaSizeRangesResponseModel, ApiException> result) {
        result.on(
          success: (IdeaSizeRangesResponseModel response) {
            ideasRanges(set: () => response.data.sizeRanges);
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );
  }

  Future<void> _fetchIdeas({required int page}) async {
    if (_isFetching) {
      return;
    }

    _isFetching = true;

    if (page > 1) {
      isLoadingMore(set: () => true);
    } else {
      viewState.setBusy(true);
    }

    await _ideaService()
        .getIdeas(
          page: page,
          limit: _itemsPerPage,
          query: currentQuery.value.isNotEmpty ? currentQuery.value : null,
          sizeRange: _selectedRange?.value,
        )
        .then(
          (Result<IdeaListResponseModel, ApiException> result) {
            result.on(
              success: (IdeaListResponseModel response) {
                final List<IdeaItem> newIdeas = response.data.ideas;
                final Pagination pagination = response.data.pagination;

                if (page == 1) {
                  ideas(set: () => newIdeas);
                } else {
                  ideas(set: () => <IdeaItem>[...ideas.value, ...newIdeas]);
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

  Future<void> _purchaseIdea(String ideaId) async {
    await _ideaService().purchaseIdea(ideaId: ideaId).then(
      (Result<IdeaPurchaseResponseModel, ApiException> result) {
        result.on(
          success: (IdeaPurchaseResponseModel response) async {
            await showAlertNotification(
              context(),
              message: TextConstants.ideaPurchaseSuccessful,
              icon: AppImages.success_alert(),
              isCallPop: false,
            );
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );
    viewState.setBusy(false);
  }

  Future<void> onPurchase(String ideaId) async {
    if (!ServiceLocator.get<AuthService>().isMember) {
      if (context() != null) {
        AppNavigation.gotoMemberShipExpiredRoute(context());
        // AppNavigation.gotoProfileRoute(context(), args: const ProfileScreenArgs(isMembershipExpired: true));
      }
      //      CustomSnackBar.show(context: context()!, message: TextConstants.premiumMembersOnly);
      return;
    } else {
      await _purchaseIdea(ideaId);
    }
  }
}

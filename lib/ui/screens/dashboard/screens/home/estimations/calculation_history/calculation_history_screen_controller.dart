import 'package:flutter/material.dart';

import '../../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../../core/models/calculation/calculation_history_response_model.dart';
import '../../../../../../../core/models/result.dart';
import '../../../../../../../core/models/rx.dart';
import '../../../../../../../core/services/calculation/calculation_service.dart';
import '../../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../../base_screen_args.dart';
import '../../../../../base_screen_controller.dart';

final class CalculationHistoryScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Service<CalculationService> _calculationService;

  CalculationHistoryScreenController(
    super.args,
    this._calculationService,
  );

  Rx<List<CalculationHistory>> historyList = Rx<List<CalculationHistory>>(<CalculationHistory>[]);

  final ScrollController scrollController = ScrollController();
  final Rx<double> scrollOffset = Rx<double>(0.0);

  final Rx<bool> isLoadingMore = Rx<bool>(false);
  int _currentPage = 1;
  int _totalPages = 1;
  bool _hasMore = true;
  bool _isFetching = false;

  static const int _itemsPerPage = 10;

  @override
  Future<void> onInitState() async {
    super.onInitState();

    scrollController.addListener(() {
      scrollOffset(set: () => scrollController.offset);

      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 && _hasMore) {
        _loadMore();
      }
    });

    await refresh();
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

    await _calculationService()
        .getCalculationHistory(
          page: page,
          limit: _itemsPerPage,
        )
        .then(
          (Result<CalculationHistoryResponseModel, ApiException> result) {
            result.on(
              success: (CalculationHistoryResponseModel response) {
                final List<CalculationHistory> newHistories = response.data.calculations;
                final Pagination pagination = response.data.pagination;

                if (page == 1) {
                  historyList(set: () => newHistories);
                } else {
                  historyList(set: () => <CalculationHistory>[...historyList.value, ...newHistories]);
                }

                _currentPage = pagination.page;
                _totalPages = pagination.pages;
                _hasMore = _currentPage < _totalPages;
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

  Future<void> deleteItem(String id) async {
    await _calculationService().deleteHistoryCalculation(id: id).then(
      (Result<bool, ApiException> result) {
        result.on(
          success: (bool response) {
            refresh();
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../core/models/idea/list/purchased_idea_list_model.dart';
import '../../../../../../core/models/result.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/services/idea/idea_service.dart';
import '../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../base_screen_args.dart';
import '../../../../base_screen_controller.dart';

final class PurchasedHistoryScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Service<IdeaService> _ideaService;

  PurchasedHistoryScreenController(super.args, this._ideaService);

  final Rx<List<PurchasedIdeaItem>> ideas = Rx<List<PurchasedIdeaItem>>(<PurchasedIdeaItem>[]);
  final ScrollController scrollController = ScrollController();
  final Rx<double> scrollOffset = Rx<double>(0.0);

  @override
  Future<void> onInitState() async {
    super.onInitState();

    scrollController.addListener(() {
      scrollOffset(set: () => scrollController.offset);
    });

    await fetchIdeas();
  }

  @override
  void onDispose() {
    scrollController.dispose();
    super.onDispose();
  }

  Future<void> fetchIdeas() async {
    viewState.setBusy(true);

    await _ideaService().getPurchasedIdeas().then(
      (Result<PurchasedIdeaListModel, ApiException> result) {
        result.on(
          success: (PurchasedIdeaListModel response) {
            ideas(set: () => response.data.ideas);
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );
    viewState.setBusy(false);
  }
}

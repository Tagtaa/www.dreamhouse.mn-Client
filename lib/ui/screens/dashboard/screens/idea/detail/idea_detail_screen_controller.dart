import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../core/models/idea/detail/idea_detail.dart';
import '../../../../../../core/models/result.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/services/idea/idea_service.dart';
import '../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../base_screen_controller.dart';
import 'idea_detail_screen_args.dart';

final class IdeaDetailScreenController extends BaseScreenController<IdeaDetailScreenArgs> {
  final Service<IdeaService> _ideaService;
  IdeaDetailScreenController(super.args, this._ideaService) : ideaId = args.ideaId;

  final Rxn<IdeaDetailResponseModel> ideaDetail = Rxn<IdeaDetailResponseModel>(null);
  late final String ideaId;

  @override
  Future<void> onInitState() async {
    super.onInitState();
    fetchIdeaDetail();
  }

  Future<void> fetchIdeaDetail() async {
    viewState.setBusy(true);

    await _ideaService().getIdeaDetail(ideaId: ideaId).then(
      (Result<IdeaDetailResponseModel, ApiException> result) {
        result.on(
          success: (IdeaDetailResponseModel response) {
            ideaDetail(set: () => response);
          },
          failure: (ApiException e) async {
            await showAlertNotification(
              context(),
              message: e.message.isNotEmpty ? e.message : 'Error occurred!',
              icon: AppImages.warning_alert(),
            );
          },
        );
      },
    );

    viewState.setBusy(false);
  }
}

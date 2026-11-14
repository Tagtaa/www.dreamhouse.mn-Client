import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../../core/models/calculation/calculation_history_response_model.dart';
import '../../../../../../../core/models/rx.dart';
import '../../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../../components/widgets/custom_back_button.dart';
import '../../../../../../components/widgets/multi_style_text.dart';
import '../../../../../../components/widgets/obx.dart';
import '../../../../../../components/widgets/refresh_icon.dart';
import '../../../../../base_screen_args.dart';
import '../../../../../base_screen_view.dart';
import 'calculation_history_screen_controller.dart';
import 'widget/history_item.dart';

@RoutePage()
final class CalculationHistoryScreenView extends BaseScreenView<CalculationHistoryScreenController, DefaultScreenArgs> {
  const CalculationHistoryScreenView({
    super.key,
    super.args = const DefaultScreenArgs(),
  }) : super(
         safeArea: const ScaffoldSafeArea(bottom: false),
       );

  @override
  State<CalculationHistoryScreenView> createState() => _CalculationHistoryScreenViewState();
}

final class _CalculationHistoryScreenViewState extends BaseScreenViewState<CalculationHistoryScreenView, CalculationHistoryScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, CalculationHistoryScreenController controller) {
    final bool isSmallScreen = context.isSmallScreen;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: context.isSmallScreen ? AppSize.emptySize : AppSize.emptySizeHigh),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Expanded(
                  child: CustomBackButton(),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    TextConstants.calculationHistoryTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelMedium(),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: AppSize.emptySizeLow),

            Obx(
              controller.historyList,
              builder: (BuildContext context, Rx<List<CalculationHistory>> historyList, Widget? child) {
                if (historyList.value.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MultiStyleText(
                            textAlign: TextAlign.center,
                            firstText: TextConstants.calculationHistoryItems,
                            secondText: TextConstants.notfound,
                            firstTextStyle: AppTextStyles.titleLarge(fontSize: AppSize.headlineFontSize),
                            secondTextStyle: isSmallScreen ? AppTextStyles.titleLarge(fontSize: AppSize.headlineFontSize, fontWeight: FontWeight.w700) : null,
                          ),
                          SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySize),
                          RefreshIconView(onTap: controller.refresh),
                        ],
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.refresh,
                    color: AppColors.primary,
                    child: ListView.builder(
                      controller: controller.scrollController,
                      addAutomaticKeepAlives: true,
                      padding: const EdgeInsets.all(AppSize.paddingZero),
                      itemCount: historyList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == historyList.value.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: AppSize.padding * 1.5),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        }

                        final CalculationHistory history = historyList.value[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSize.paddingLow),
                          child: HistoryItem(
                            history: history,
                            onDelete: () {
                              controller.deleteItem(history.id ?? '');
                            },
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

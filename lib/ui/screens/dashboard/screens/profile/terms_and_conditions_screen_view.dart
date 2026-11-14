import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../core/configs/constants/text_constants.dart';
import '../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../components/widgets/custom_back_button.dart';

@RoutePage()
class TermsAndConditionsScreenView extends StatelessWidget {
  const TermsAndConditionsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: context.isSmallScreen ? AppSize.emptySize : AppSize.emptySizeHigh),
            Row(
              children: <Widget>[
                const Expanded(
                  child: CustomBackButton(),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    TextConstants.termsAndConditions,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelMedium(),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: AppSize.emptySize),

            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  TextConstants.termsText,
                  style: AppTextStyles.labelSmall(color: AppColors.inverseSurface),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

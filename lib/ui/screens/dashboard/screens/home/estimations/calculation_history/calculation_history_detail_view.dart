import 'package:flutter/material.dart';

import '../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../../core/models/calculation/calculation_history_response_model.dart';
import '../../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../../components/widgets/custom_back_button.dart';
import '../../../../../../components/widgets/custom_image_network.dart';

class CalculationHistoryDetailView extends StatelessWidget {
  const CalculationHistoryDetailView({
    super.key,
    required this.calculationHistory,
  });

  final CalculationHistory calculationHistory;

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = context.isSmallScreen;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Header
            Padding(
              padding: const EdgeInsets.all(AppSize.paddingNormal),
              child: Row(
                children: <Widget>[
                  const CustomBackButton(),
                  const SizedBox(width: AppSize.paddingLow),
                  Expanded(
                    child: Text(
                      TextConstants.detailTitle,
                      style: AppTextStyles.labelMedium(
                        fontSize: isSmallScreen ? AppSize.titleFontSize : AppSize.headlineFontSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: AppSize.iconSizeNormal),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildMainInfoCard(context, isSmallScreen),
                    const SizedBox(height: AppSize.paddingNormal),

                    if (calculationHistory.inputs != null) ...<Widget>[
                      _buildSectionTitle(context, TextConstants.inputs, isSmallScreen),
                      const SizedBox(height: AppSize.paddingLow),
                      _buildInputsCard(context, isSmallScreen),
                      const SizedBox(height: AppSize.paddingNormal),
                    ],

                    if (calculationHistory.results != null) ...<Widget>[
                      _buildSectionTitle(context, TextConstants.results, isSmallScreen),
                      const SizedBox(height: AppSize.paddingLow),
                      _buildResultsCard(context, isSmallScreen),
                      const SizedBox(height: AppSize.paddingNormal),
                    ],

                    if (calculationHistory.results?.materials?.isNotEmpty == true) ...<Widget>[
                      _buildSectionTitle(context, TextConstants.detailMaterials, isSmallScreen),
                      const SizedBox(height: AppSize.paddingLow),
                      _buildMaterialsCard(context, isSmallScreen),
                      const SizedBox(height: AppSize.paddingNormal),
                    ],

                    if (calculationHistory.results?.additionalCosts?.isNotEmpty == true) ...<Widget>[
                      _buildSectionTitle(context, TextConstants.additionalCosts, isSmallScreen),
                      const SizedBox(height: AppSize.paddingLow),
                      _buildAdditionalCostsCard(context, isSmallScreen),
                      const SizedBox(height: AppSize.paddingNormal),
                    ],

                    if (calculationHistory.summary != null) ...<Widget>[
                      _buildSectionTitle(context, TextConstants.summary, isSmallScreen),
                      const SizedBox(height: AppSize.paddingLow),
                      _buildSummaryCard(context, isSmallScreen),
                      const SizedBox(height: AppSize.paddingNormal),
                    ],

                    if (calculationHistory.shapeInfo != null) ...<Widget>[
                      _buildSectionTitle(context, TextConstants.shapeInformation, isSmallScreen),
                      const SizedBox(height: AppSize.paddingLow),
                      _buildShapeInfoCard(context, isSmallScreen),
                      const SizedBox(height: AppSize.paddingNormal),
                    ],

                    if (calculationHistory.thicknessInfo != null) ...<Widget>[
                      _buildSectionTitle(context, TextConstants.thicknessInformation, isSmallScreen),
                      const SizedBox(height: AppSize.paddingLow),
                      _buildThicknessInfoCard(context, isSmallScreen),
                      const SizedBox(height: AppSize.paddingNormal),
                    ],

                    _buildAdditionalInfoCard(context, isSmallScreen),
                    const SizedBox(height: AppSize.paddingHigh),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputsCard(BuildContext context, bool isSmallScreen) {
    final Inputs? inputs = calculationHistory.inputs;
    if (inputs == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.radius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.surface.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Column(
          children: <Widget>[
            // Selected Type Model
            if (inputs.selectedTypeModel != null && inputs.selectedTypeModel is Map) ...<Widget>[
              _buildModelInfo(TextConstants.type, inputs.selectedTypeModel as Map<String, dynamic>, isSmallScreen),
              const SizedBox(height: AppSize.paddingLow),
            ],

            // Selected Shape Model
            if (inputs.selectedShapeModel != null && inputs.selectedShapeModel is Map) ...<Widget>[
              _buildModelInfo(TextConstants.shape, inputs.selectedShapeModel as Map<String, dynamic>, isSmallScreen),
              const SizedBox(height: AppSize.paddingLow),
            ],

            // Selected Thickness Model
            if (inputs.selectedThicknessModel != null && inputs.selectedThicknessModel is Map) ...<Widget>[
              _buildModelInfo(TextConstants.thickness, inputs.selectedThicknessModel as Map<String, dynamic>, isSmallScreen),
              const SizedBox(height: AppSize.paddingLow),
            ],

            // Calculation Custom Model
            if (inputs.calculationCustomModel != null && inputs.calculationCustomModel is Map) ...<Widget>[
              _buildCustomModelInfo(inputs.calculationCustomModel as Map<String, dynamic>, isSmallScreen),
              const SizedBox(height: AppSize.paddingLow),
            ],

            // Selected Material Model
            if (inputs.selectedMaterialModel != null) _buildDataRow(TextConstants.materialId, inputs.selectedMaterialModel.toString(), isSmallScreen),

            // Block dimensions
            if (inputs.blockLength != null) _buildDataRow(TextConstants.detailLength, '${inputs.blockLength} ${TextConstants.cm}', isSmallScreen),
            if (inputs.blockWidth != null) _buildDataRow(TextConstants.detailWidth, '${inputs.blockWidth} ${TextConstants.cm}', isSmallScreen),
            if (inputs.blockHeight != null) _buildDataRow(TextConstants.detailHeight, '${inputs.blockHeight} ${TextConstants.cm}', isSmallScreen),
            if (inputs.blockThickness != null) _buildDataRow(TextConstants.thickness, '${inputs.blockThickness} ${TextConstants.cm}', isSmallScreen),

            // Waste information
            if (inputs.wastePercentage != null) _buildDataRow(TextConstants.wastePercentage, '${inputs.wastePercentage}%', isSmallScreen),
            if (inputs.includeWaste != null) _buildDataRow(TextConstants.includeWaste, inputs.includeWaste! ? TextConstants.includeWasteYes : TextConstants.includeWasteNo, isSmallScreen),

            // Windows and Doors
            if (inputs.windows?.isNotEmpty == true) _buildDataRow(TextConstants.windows, '${inputs.windows!.length} ${TextConstants.windows}', isSmallScreen),
            if (inputs.doors?.isNotEmpty == true) _buildDataRow(TextConstants.doors, '${inputs.doors!.length} ${TextConstants.doors}', isSmallScreen),
            if (inputs.windowList?.isNotEmpty == true) _buildDataRow(TextConstants.windowList, '${inputs.windowList!.length} ${TextConstants.items}', isSmallScreen),
            if (inputs.doorList?.isNotEmpty == true) _buildDataRow(TextConstants.doorList, '${inputs.doorList!.length} ${TextConstants.items}', isSmallScreen),

            // Totals
            if (inputs.totalArea != null) _buildDataRow(TextConstants.totalArea, '${inputs.totalArea!.toStringAsFixed(2)} m²', isSmallScreen),
            if (inputs.totalVolume != null) _buildDataRow(TextConstants.totalVolume, '${inputs.totalVolume!.toStringAsFixed(2)} m³', isSmallScreen),
            if (inputs.materialItemCount != null) _buildDataRow(TextConstants.material, '${inputs.materialItemCount} ${TextConstants.onePiece}', isSmallScreen),
            if (inputs.totalPrice != null) _buildDataRow(TextConstants.totalCost, '${inputs.totalPrice!.toStringAsFixed(2)} ₮', isSmallScreen),

            // Ingredients
            if (inputs.ingCalcModelList?.isNotEmpty == true) ...<Widget>[
              const SizedBox(height: AppSize.paddingLow),
              Text(
                TextConstants.ingredients,
                style: AppTextStyles.labelMedium(
                  color: AppColors.onSurface,
                  fontSize: isSmallScreen ? AppSize.bodyFontSize : AppSize.titleFontSize,
                ),
              ),
              const SizedBox(height: AppSize.paddingLowest),
              ...inputs.ingCalcModelList!.map((IngCalcModel ingredient) => _buildIngredientRow(ingredient, isSmallScreen)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultsCard(BuildContext context, bool isSmallScreen) {
    final Results? results = calculationHistory.results;
    if (results == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.radius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.surface.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Column(
          children: <Widget>[
            if (results.area != null) _buildDataRow(TextConstants.area, '${results.area!.toStringAsFixed(2)} m²', isSmallScreen),
            if (results.volume != null) _buildDataRow(TextConstants.volume, '${results.volume!.toStringAsFixed(2)} m³', isSmallScreen),
            if (results.perimeter != null) _buildDataRow(TextConstants.perimeter, '${results.perimeter!.toStringAsFixed(2)} m', isSmallScreen),
            if (results.totalArea != null) _buildDataRow(TextConstants.totalArea, '${results.totalArea!.toStringAsFixed(2)} m²', isSmallScreen),
            if (results.totalVolume != null) _buildDataRow(TextConstants.totalVolume, '${results.totalVolume!.toStringAsFixed(2)} m³', isSmallScreen),

            // Cost information with highlight
            if (results.totalMaterialCost != null) _buildCostRow(TextConstants.detailMaterialCost, '${results.totalMaterialCost!.toStringAsFixed(2)} ₮', isSmallScreen),
            if (results.estimatedLaborCost != null) _buildCostRow(TextConstants.laborCost, '${results.estimatedLaborCost!.toStringAsFixed(2)} ₮', isSmallScreen),
            if (results.totalCost != null) _buildTotalCostRow(TextConstants.totalCost, '${results.totalCost!.toStringAsFixed(2)} ₮', isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildCostRow(String label, String value, bool isSmallScreen) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSize.paddingLowest),
      padding: const EdgeInsets.all(AppSize.paddingLow),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppSize.radiusLowest),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyles.bodyMedium(
                color: AppColors.surface,
                fontSize: isSmallScreen ? AppSize.captionFontSize : AppSize.labelFontSize,
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTextStyles.titleMedium(
                color: AppColors.primary,
                fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.bodyFontSize,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalCostRow(String label, String value, bool isSmallScreen) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSize.paddingLowest),
      padding: const EdgeInsets.all(AppSize.paddingNormal),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSize.radiusLow),
        border: Border.all(
          color: AppColors.secondary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.labelMedium(
                color: AppColors.secondary,
                fontSize: isSmallScreen ? AppSize.bodyFontSize : AppSize.titleFontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Text(
            value,
            style: AppTextStyles.headlineMedium(
              color: AppColors.secondary,
              fontSize: isSmallScreen ? AppSize.titleFontSize : AppSize.headlineFontSize,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialsCard(BuildContext context, bool isSmallScreen) {
    final List<dynamic>? materials = calculationHistory.results?.materials;
    if (materials == null || materials.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.radius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.surface.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < materials.length; i++) ...<Widget>[
              if (i > 0) const Divider(color: AppColors.borderColor, thickness: 1),
              _buildMaterialItem(materials[i], isSmallScreen),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialItem(dynamic material, bool isSmallScreen) {
    if (material is Map<String, dynamic>) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSize.paddingLowest),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (material['materialId'] != null) ...<Widget>[
                        Text(
                          '${TextConstants.materialIdLabel} ${material['materialId']}',
                          style: AppTextStyles.captionText(
                            color: AppColors.surface,
                            fontSize: AppSize.captionFontSize,
                          ),
                        ),
                        const SizedBox(height: AppSize.paddingLowest),
                      ],
                      Text(
                        material['name']?.toString() ?? TextConstants.materialDefault,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.onSurface,
                          fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.bodyFontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      if (material['quantity'] != null)
                        Text(
                          '${TextConstants.quantity} ${material['quantity']}',
                          style: AppTextStyles.titleMedium(
                            color: AppColors.onSurface,
                            fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.bodyFontSize,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.paddingLowest),
            Row(
              children: <Widget>[
                if (material['unit'] != null) ...<Widget>[
                  Text(
                    '${TextConstants.unit}: ${material['unit']}',
                    style: AppTextStyles.captionText(
                      color: AppColors.surface,
                      fontSize: AppSize.captionFontSize,
                    ),
                  ),
                  const SizedBox(width: AppSize.paddingNormal),
                ],
                if (material['unitPrice'] != null) ...<Widget>[
                  Text(
                    '${TextConstants.unitPrice} ${material['unitPrice']} ₮',
                    style: AppTextStyles.captionText(
                      color: AppColors.surface,
                      fontSize: AppSize.captionFontSize,
                    ),
                  ),
                ],
              ],
            ),
            if (material['totalPrice'] != null) ...<Widget>[
              const SizedBox(height: AppSize.paddingLowest),
              Text(
                '${TextConstants.totalWithColon} ${material['totalPrice']} ₮',
                style: AppTextStyles.bodyMedium(
                  color: AppColors.primary,
                  fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.bodyFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            if (material['amount'] != null && material['price'] != null) ...<Widget>[
              const SizedBox(height: AppSize.paddingLowest),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${TextConstants.amount} ${material['amount']}',
                    style: AppTextStyles.captionText(
                      color: AppColors.surface,
                      fontSize: AppSize.captionFontSize,
                    ),
                  ),
                  Text(
                    '${TextConstants.priceLabel} ${material['price']} ₮',
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.primary,
                      fontSize: AppSize.captionFontSize,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    }

    return Text(
      material.toString(),
      style: AppTextStyles.bodyMedium(
        fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.bodyFontSize,
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, bool isSmallScreen) {
    return Text(
      title,
      style: AppTextStyles.labelMedium(
        fontSize: isSmallScreen ? AppSize.titleFontSize : AppSize.headlineFontSize,
        color: AppColors.onSurface,
      ),
    );
  }

  Widget _buildAdditionalInfoCard(BuildContext context, bool isSmallScreen) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.radius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.surface.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              TextConstants.additionalInformation,
              style: AppTextStyles.labelMedium(
                color: AppColors.onSurface,
                fontSize: isSmallScreen ? AppSize.bodyFontSize : AppSize.titleFontSize,
              ),
            ),
            const SizedBox(height: AppSize.paddingLow),
            if (calculationHistory.id != null) _buildDataRow(TextConstants.id, calculationHistory.id!, isSmallScreen),
            if (calculationHistory.type != null) _buildDataRow(TextConstants.type, calculationHistory.type!, isSmallScreen),
            if (calculationHistory.status != null) _buildDataRow(TextConstants.status, calculationHistory.status!, isSmallScreen),
            if (calculationHistory.tags?.isNotEmpty == true) _buildDataRow(TextConstants.tags, calculationHistory.tags!.join(', '), isSmallScreen),
            if (calculationHistory.sharedWith?.isNotEmpty == true) _buildDataRow(TextConstants.sharedWith, '${calculationHistory.sharedWith!.length} ${TextConstants.sharedWithUsers}', isSmallScreen),
            if (calculationHistory.lastAccessedAt != null) _buildDataRow(TextConstants.lastAccessed, calculationHistory.lastAccessedAt!.timeAgo, isSmallScreen),
            if (calculationHistory.updatedAt != null) _buildDataRow(TextConstants.updated, calculationHistory.updatedAt!.timeAgo, isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value, bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.paddingLowest),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyles.bodyMedium(
                color: AppColors.surface,
                fontSize: isSmallScreen ? AppSize.captionFontSize : AppSize.labelFontSize,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTextStyles.titleMedium(
                color: AppColors.onSurface,
                fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.bodyFontSize,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientRow(IngCalcModel ingredient, bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.paddingLowest),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  ingredient.name ?? TextConstants.materialDefault,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.onSurface,
                    fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.bodyFontSize,
                  ),
                ),
                if (ingredient.unit != null) ...<Widget>[
                  const SizedBox(height: AppSize.paddingLowest),
                  Text(
                    '${TextConstants.unit}: ${ingredient.unit}',
                    style: AppTextStyles.captionText(
                      color: AppColors.surface,
                      fontSize: AppSize.captionFontSize,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (ingredient.amountValue != null)
                  Text(
                    ingredient.amountValue.toString(),
                    style: AppTextStyles.titleMedium(
                      color: AppColors.onSurface,
                      fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.bodyFontSize,
                    ),
                  ),
                if (ingredient.priceValue != null) ...<Widget>[
                  const SizedBox(height: AppSize.paddingLowest),
                  Text(
                    '${ingredient.priceValue} ₮',
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.primary,
                      fontSize: AppSize.captionFontSize,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModelInfo(String title, Map<String, dynamic> model, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppTextStyles.labelMedium(
            color: AppColors.onSurface,
            fontSize: isSmallScreen ? AppSize.bodyFontSize : AppSize.titleFontSize,
          ),
        ),
        const SizedBox(height: AppSize.paddingLowest),
        if (model['name'] != null) _buildDataRow(TextConstants.name, model['name'].toString(), isSmallScreen),
        if (model['description'] != null) _buildDataRow(TextConstants.description, model['description'].toString(), isSmallScreen),
        if (model['key'] != null) _buildDataRow(TextConstants.key, model['key'].toString(), isSmallScreen),
        if (model['imageUrl'] != null) ...<Widget>[
          const SizedBox(height: AppSize.paddingLowest),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.radiusLow),
              child: CustomImageNetwork(model['imageUrl'].toString()),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCustomModelInfo(Map<String, dynamic> customModel, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          TextConstants.customModel,
          style: AppTextStyles.labelMedium(
            color: AppColors.onSurface,
            fontSize: isSmallScreen ? AppSize.bodyFontSize : AppSize.titleFontSize,
          ),
        ),
        const SizedBox(height: AppSize.paddingLowest),
        if (customModel['blockLength'] != null) _buildDataRow(TextConstants.detailLength, '${customModel['blockLength']} ${TextConstants.cm}', isSmallScreen),
        if (customModel['blockWidth'] != null) _buildDataRow(TextConstants.detailWidth, '${customModel['blockWidth']} ${TextConstants.cm}', isSmallScreen),
        if (customModel['blockHeight'] != null) _buildDataRow(TextConstants.detailHeight, '${customModel['blockHeight']} ${TextConstants.cm}', isSmallScreen),
        if (customModel['blockThickness'] != null) _buildDataRow(TextConstants.thickness, '${customModel['blockThickness']} ${TextConstants.cm}', isSmallScreen),
        if (customModel['price'] != null) _buildDataRow(TextConstants.price, '${customModel['price']} ₮', isSmallScreen),
        if (customModel['imageUrl'] != null) ...<Widget>[
          const SizedBox(height: AppSize.paddingLowest),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.radiusLow),
              child: CustomImageNetwork(customModel['imageUrl'].toString()),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAdditionalCostsCard(BuildContext context, bool isSmallScreen) {
    final List<dynamic>? additionalCosts = calculationHistory.results?.additionalCosts;
    if (additionalCosts == null || additionalCosts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.radius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.surface.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < additionalCosts.length; i++) ...<Widget>[
              if (i > 0) const Divider(color: AppColors.borderColor, thickness: 1),
              if (additionalCosts[i] is Map<String, dynamic>)
                _buildAdditionalCostItem(additionalCosts[i] as Map<String, dynamic>, isSmallScreen)
              else
                Text(
                  additionalCosts[i].toString(),
                  style: AppTextStyles.bodyMedium(
                    fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.bodyFontSize,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalCostItem(Map<String, dynamic> cost, bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.paddingLowest),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              cost['name']?.toString() ?? cost['description']?.toString() ?? TextConstants.additionalCost,
              style: AppTextStyles.bodyMedium(
                color: AppColors.onSurface,
                fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.bodyFontSize,
              ),
            ),
          ),
          if (cost['amount'] != null || cost['price'] != null)
            Text(
              '${cost['amount'] ?? cost['price']} ₮',
              style: AppTextStyles.titleMedium(
                color: AppColors.primary,
                fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.bodyFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, bool isSmallScreen) {
    final Summary? summary = calculationHistory.summary;
    if (summary == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.radius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.surface.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Column(
          children: <Widget>[
            if (summary.totalPrice != null) _buildDataRow(TextConstants.totalCost, '${summary.totalPrice!.toStringAsFixed(2)} ₮', isSmallScreen),
            if (summary.totalVolume != null) _buildDataRow(TextConstants.totalVolume, '${summary.totalVolume!.toStringAsFixed(2)} m³', isSmallScreen),
            if (summary.materialItemCount != null) _buildDataRow(TextConstants.material, '${summary.materialItemCount} ${TextConstants.onePiece}', isSmallScreen),
            if (summary.doorCount != null) _buildDataRow(TextConstants.doors, '${summary.doorCount} ${TextConstants.doors}', isSmallScreen),
            if (summary.windowCount != null) _buildDataRow(TextConstants.windows, '${summary.windowCount} ${TextConstants.windows}', isSmallScreen),
            if (summary.ingredientCount != null) _buildDataRow(TextConstants.ingredients, '${summary.ingredientCount} ${TextConstants.items}', isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildShapeInfoCard(BuildContext context, bool isSmallScreen) {
    final dynamic shapeInfo = calculationHistory.shapeInfo;
    if (shapeInfo == null) {
      return const SizedBox.shrink();
    }

    if (shapeInfo is! Map<String, dynamic>) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.radius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.surface.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (shapeInfo['name'] != null) _buildDataRow(TextConstants.name, shapeInfo['name'].toString(), isSmallScreen),
            if (shapeInfo['description'] != null) _buildDataRow(TextConstants.description, shapeInfo['description'].toString(), isSmallScreen),
            if (shapeInfo['imageUrl'] != null) ...<Widget>[
              const SizedBox(height: AppSize.paddingLow),
              SizedBox(
                height: 150,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.radiusLow),
                  child: CustomImageNetwork(shapeInfo['imageUrl'].toString()),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildThicknessInfoCard(BuildContext context, bool isSmallScreen) {
    final dynamic thicknessInfo = calculationHistory.thicknessInfo;
    if (thicknessInfo == null) {
      return const SizedBox.shrink();
    }

    if (thicknessInfo is! Map<String, dynamic>) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.radius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.surface.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (thicknessInfo['name'] != null) _buildDataRow(TextConstants.name, thicknessInfo['name'].toString(), isSmallScreen),
            if (thicknessInfo['thickness'] != null) _buildDataRow(TextConstants.thickness, '${thicknessInfo['thickness']} ${thicknessInfo['unit'] ?? TextConstants.cm}', isSmallScreen),
            if (thicknessInfo['imageUrl'] != null) ...<Widget>[
              const SizedBox(height: AppSize.paddingLow),
              SizedBox(
                height: 150,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.radiusLow),
                  child: CustomImageNetwork(thicknessInfo['imageUrl'].toString()),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMainInfoCard(BuildContext context, bool isSmallScreen) {
    // Prefer materialImageUrl, fallback to inputs.imageUrl
    final String? imageUrl = calculationHistory.materialImageUrl ?? calculationHistory.inputs?.imageUrl;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.radius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.surface.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                // Image
                SizedBox(
                  height: isSmallScreen ? 80 : 100,
                  width: isSmallScreen ? 80 : 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.radiusLow),
                    child: imageUrl != null
                        ? CustomImageNetwork(imageUrl)
                        : Container(
                            color: AppColors.secondaryBackground,
                            child: const Icon(
                              Icons.calculate,
                              color: AppColors.surface,
                              size: AppSize.iconSize,
                            ),
                          ),
                  ),
                ),

                const SizedBox(width: AppSize.paddingNormal),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        calculationHistory.typeName ?? TextConstants.detailType,
                        style: AppTextStyles.labelMedium(
                          color: AppColors.onSurface,
                          fontSize: isSmallScreen ? AppSize.titleFontSize : AppSize.headlineFontSize,
                        ),
                      ),
                      const SizedBox(height: AppSize.paddingLowest),
                      Text(
                        calculationHistory.materialName ?? TextConstants.detailMaterial,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.surface,
                          fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.bodyFontSize,
                        ),
                      ),
                      const SizedBox(height: AppSize.paddingLow),

                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSize.paddingLow,
                              vertical: AppSize.paddingLowest,
                            ),
                            decoration: BoxDecoration(
                              color: calculationHistory.status == 'completed' || calculationHistory.status == 'calculated' ? AppColors.primary.withOpacity(0.1) : AppColors.surface.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppSize.radiusLowest),
                            ),
                            child: Text(
                              calculationHistory.status?.toUpperCase() ?? TextConstants.pending,
                              style: AppTextStyles.captionText(
                                color: calculationHistory.status == 'completed' || calculationHistory.status == 'calculated' ? AppColors.primary : AppColors.surface,
                                fontSize: AppSize.captionFontSize,
                              ),
                            ),
                          ),

                          const SizedBox(width: AppSize.paddingLow),

                          if (calculationHistory.isBookmarked == true)
                            const Icon(
                              Icons.bookmark,
                              color: AppColors.star,
                              size: AppSize.iconSizeLow,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Created date
            const SizedBox(height: AppSize.paddingLow),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.access_time,
                  color: AppColors.surface,
                  size: AppSize.iconSizeLowest,
                ),
                const SizedBox(width: AppSize.paddingLowest),
                Text(
                  '${TextConstants.created}: ${calculationHistory.createdAt?.timeAgo ?? ''}',
                  style: AppTextStyles.captionText(
                    color: AppColors.surface,
                    fontSize: AppSize.captionFontSize,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

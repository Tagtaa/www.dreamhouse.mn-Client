import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../core/init/app_locator.dart';
import '../../../../../../core/services/auth/auth_service.dart';
import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/widgets/custom_image_network.dart';
import '../../../../../components/widgets/gesture_detector.dart';
import '../score_and_favorite_view.dart';

const double _thickness = 1.0;

const double _dividerWidth = 60.0;
const double _dividerHeight = 4.0;
const double _radiusSize = 3.0;
double progress = 0.7;

class MaterialItemCard extends StatefulWidget {
  final MaterialItem materialItem;
  final void Function(String id) toggleOnLike;

  const MaterialItemCard({
    super.key,
    required this.materialItem,
    required this.toggleOnLike,
  });

  @override
  State<MaterialItemCard> createState() => _MaterialItemCardState();
}

class _MaterialItemCardState extends State<MaterialItemCard> {
  bool _showDetail = false;

  void toggleDetail() {
    setState(() {
      _showDetail = !_showDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = context.isSmallScreen;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.paddingLow),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.radiusHigh),
          color: AppColors.background,
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: AppSize.paddingLow),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingLow),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.bottomRight,
                            children: <Widget>[
                              AppImages.shape_stroke(
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(AppSize.radiusHigh),
                                child: switch (widget.materialItem.images != null && widget.materialItem.images!.isNotEmpty) {
                                  true => CustomImageNetwork(widget.materialItem.images!.first),
                                  false => const Placeholder(),
                                },
                              ),

                              Positioned(
                                bottom: AppSize.emptySize,
                                left: 0,
                                right: 0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(_radiusSize),
                                    child: SizedBox(
                                      width: _dividerWidth,
                                      height: _dividerHeight,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: _dividerWidth * progress,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(
                                                _radiusSize,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(_radiusSize),
                                                  bottomRight: Radius.circular(_radiusSize),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSize.emptySize),

                        Text(
                          widget.materialItem.name ?? '',
                          style: AppTextStyles.headlineMedium(fontWeight: FontWeight.w700),
                        ),

                        Row(
                          children: <Widget>[
                            // Material prices are shown to users with an active membership only
                            if (ServiceLocator.get<AuthService>().isMember)
                              Text(
                                '${widget.materialItem.price}₮',
                                style: AppTextStyles.headlineMedium(fontWeight: FontWeight.w600),
                              ),
                            const Spacer(),
                            Text(
                              '${TextConstants.onePiece} / ${TextConstants.sizeLwh}: ${widget.materialItem.length}×${widget.materialItem.width}×${widget.materialItem.height}${widget.materialItem.unit}',
                              style: AppTextStyles.labelSmall(
                                color: AppColors.inverseSurface,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSize.emptySizeLowest),
                      ],
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.secondaryBackground,
                        width: AppSize.one,
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: CustomGestureDetector(
                              onTap: toggleDetail,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSize.paddingLow,
                                  horizontal: AppSize.padding,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.article_outlined,
                                      size: AppSize.iconSizeLowest,
                                      color: AppColors.onSurface,
                                    ),
                                    const SizedBox(width: AppSize.emptySizeLowest),
                                    Text(
                                      TextConstants.detail,
                                      style: AppTextStyles.labelSmall(
                                        color: AppColors.onSurface,
                                        fontSize: AppSize.bodyFontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const VerticalDivider(
                            thickness: _thickness,
                            color: AppColors.secondaryBackground,
                            width: AppSize.one,
                          ),

                          Expanded(
                            child: CustomGestureDetector(
                              onTap: () {},

                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSize.paddingLow,
                                  horizontal: AppSize.padding,
                                ),
                                child: CustomGestureDetector(
                                  onTap: () => widget.toggleOnLike(widget.materialItem.id ?? ''),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        widget.materialItem.isLiked ?? false ? Icons.favorite : Icons.favorite_border_outlined,
                                        size: AppSize.iconSizeLowest,
                                        color: widget.materialItem.isLiked ?? false ? AppColors.primary : AppColors.surface,
                                      ),
                                      const SizedBox(width: AppSize.emptySizeLowest),
                                      Text(
                                        widget.materialItem.isLiked ?? false ? TextConstants.unlike : TextConstants.like,
                                        style: AppTextStyles.labelMedium(
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: AppSize.durationLow),
                    child: _showDetail
                        ? Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(AppSize.padding),
                                // Description from the dashboard editor (HTML: paragraphs, lists, bold...)
                                child: Html(
                                  data: widget.materialItem.description ?? '',
                                  style: <String, Style>{
                                    'body': Style(margin: Margins.zero, padding: HtmlPaddings.zero),
                                    'p': Style(margin: Margins.only(bottom: 8)),
                                  },
                                ),
                              ),
                              // Where to buy (members only — the API leaves it out for others)
                              if (ServiceLocator.get<AuthService>().isMember && !(widget.materialItem.contact?.isEmpty ?? true))
                                _ContactView(contact: widget.materialItem.contact!)
                              else if (!ServiceLocator.get<AuthService>().isMember)
                                const _ContactLockedView(),
                              const SizedBox(height: AppSize.paddingLow),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            ScoreAndFavoriteView(
              like: widget.materialItem.likeCount ?? 0,
              rating: widget.materialItem.rating?.toDouble() ?? 0.0,
              rightPadding: AppSize.paddingHighest,
              topPadding: AppSize.paddingHigh,
              iconSize: AppSize.icon,
              radiusSize: AppSize.radius,
              fontSize: AppSize.bodyFontSize,
              padding: isSmallScreen ? AppSize.paddingLowest : AppSize.padding,
            ),
          ],
        ),
      ),
    );
  }
}


/// Phone (tap to call), address and a button that opens the Google Map.
class _ContactView extends StatelessWidget {
  final MaterialContact contact;

  const _ContactView({required this.contact});

  Future<void> _open(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String phone = contact.phone ?? '';
    final String address = contact.address ?? '';
    final String map = contact.mapEmbedUrl ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Холбоо барих', style: AppTextStyles.labelSmall(color: AppColors.inverseSurface)),
          const SizedBox(height: AppSize.paddingLow),
          if (phone.isNotEmpty)
            InkWell(
              onTap: () => _open(Uri(scheme: 'tel', path: phone.replaceAll(' ', ''))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.phone_outlined, size: 18),
                    const SizedBox(width: 8),
                    Text(phone, style: AppTextStyles.labelMedium(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          if (address.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.place_outlined, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(address, style: AppTextStyles.labelMedium())),
                ],
              ),
            ),
          if (map.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: OutlinedButton.icon(
                onPressed: () => _open(Uri.parse(map)),
                icon: const Icon(Icons.map_outlined, size: 18),
                label: const Text('Газрын зураг нээх'),
              ),
            ),
        ],
      ),
    );
  }
}


/// Shown instead of the contact details to users without an active membership.
class _ContactLockedView extends StatelessWidget {
  const _ContactLockedView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Холбоо барих', style: AppTextStyles.labelSmall(color: AppColors.inverseSurface)),
          const SizedBox(height: AppSize.paddingLow),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.phone_outlined, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Гишүүнчлэл авсан хэрэглэгчид материал худалдан авах холбоо барих мэдээллийг харах боломжтой',
                  style: AppTextStyles.labelMedium(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

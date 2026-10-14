import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/extensions/shimmer_extension.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductImageCarousel extends StatelessWidget {
  const ProductImageCarousel({
    super.key,
    required this.onPageChanged,
    required this.images,
    required this.controller,
    required this.nextSlide,
    required this.prevSlide,
    required this.isFav,
    required this.icon,
    required this.color,
    required this.index,
  });
  final void Function(int, CarouselPageChangedReason) onPageChanged;
  final List<String> images;
  final CarouselSliderController controller;
  final VoidCallback nextSlide;
  final VoidCallback prevSlide;
  final void Function()? isFav;
  final IconData icon;
  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.decorationImageSlider,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.x3),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider(
              carouselController: controller,
              options: CarouselOptions(
                height: 320,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                onPageChanged: onPageChanged,
              ),
              items: images.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacing.x3,
                        horizontal: AppSpacing.x2,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: item,
                        fit: BoxFit.contain,
                        placeholder: (context, url) =>
                            Container().withShimmer(isShow: true),
                        errorWidget: (context, url, error) =>
                            Image.asset(AppAssets.errorIcon),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            Positioned(
              top: AppSpacing.x2,
              right: AppSpacing.x2,
              child: Container(
                decoration: AppStyles.favInProductDetailsDecoration,
                child: IconButton(
                  icon: Icon(icon, color: color),
                  onPressed: isFav,
                ),
              ),
            ),

            Positioned(
              left: 12,
              child: _buildNavButton(
                icon: Icons.arrow_back_ios_new,
                onTap: prevSlide,
              ),
            ),

            Positioned(
              right: 12,
              child: _buildNavButton(
                icon: Icons.arrow_forward_ios,
                onTap: nextSlide,
              ),
            ),

            Positioned(
              bottom: 16,
              child: AnimatedSmoothIndicator(
                activeIndex: index,
                count: images.length,
                onDotClicked: (index) {
                  controller.animateToPage(index);
                },
                effect: ScrollingDotsEffect(
                  activeDotColor: AppColors.primary,
                  dotColor: AppColors.bodyLight,
                  dotWidth: AppSpacing.x1,
                  dotHeight: AppSpacing.x1,
                  activeDotScale: 1.2,
                  spacing: AppSpacing.x1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: AppStyles.favInProductDetailsDecoration,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: AppSpacing.x2, color: AppColors.primary),
        onPressed: onTap,
      ),
    );
  }
}

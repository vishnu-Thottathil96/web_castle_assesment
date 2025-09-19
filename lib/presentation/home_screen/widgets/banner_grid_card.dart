import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/core/constants/app_colors/app_colors.dart';
import 'package:flutter_template/core/util/responsive_util.dart';

class BannerGridCard extends StatelessWidget {
  final String image;

  const BannerGridCard({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = ResponsiveHelper.scaleWidth(context, 165);
    double cardHeight = ResponsiveHelper.scaleHeight(context, 230);

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.scaleRadius(context, 12),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.scaleRadius(context, 12),
        ),
        child: Positioned.fill(
          child: Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.image,
              size: ResponsiveHelper.scaleWidth(context, 80),
              color: AppColors.error,
            ),
          ),
        ),
      ),
    );
  }
}

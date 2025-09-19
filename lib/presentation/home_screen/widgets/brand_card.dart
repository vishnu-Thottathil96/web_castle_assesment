import 'package:flutter/material.dart';
import 'package:flutter_template/core/constants/app_colors/app_colors.dart';
import 'package:flutter_template/core/util/responsive_util.dart';

class BrandCard extends StatelessWidget {
  final String imageUrl;

  const BrandCard({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveHelper.scaleHeight(context, 104),
      width: ResponsiveHelper.scaleWidth(context, 130),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius:
            BorderRadius.circular(ResponsiveHelper.scaleRadius(context, 10)),
      ),
      clipBehavior: Clip.antiAlias, 
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain, 
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    );
  }
}

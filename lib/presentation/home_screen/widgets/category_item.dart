import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/core/util/responsive_util.dart';

class CategoryItem extends StatelessWidget {
  final String imageUrl;
  final String label;
  final Color backgroundColor;

  const CategoryItem({
    super.key,
    required this.imageUrl,
    required this.label,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    double circleSize =
        ResponsiveHelper.scaleWidth(context, 70); 

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: circleSize,
              width: circleSize,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Image.network(
                imageUrl,
                height: circleSize * 0.6, 
                width: circleSize * 0.6,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: ResponsiveHelper.scaleHeight(context, 6)),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}

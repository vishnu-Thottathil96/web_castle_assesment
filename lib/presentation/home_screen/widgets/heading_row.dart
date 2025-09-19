import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/core/constants/app_colors/app_colors.dart';

class HeadingRow extends StatelessWidget {
  final String heading;
  final VoidCallback? onViewAllTap;

  const HeadingRow({
    super.key,
    required this.heading,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
        ),
        GestureDetector(
          onTap: onViewAllTap,
          child: Text(
            'view All',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.black,
                  color: AppColors.black,
                ),
          ),
        ),
      ],
    );
  }
}

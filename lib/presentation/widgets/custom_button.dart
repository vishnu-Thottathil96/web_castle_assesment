import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/core/constants/app_colors/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double width;
  final double height;
  final double edgeRadius;
  final bool? isBoldText;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.borderColor,
    this.textColor,
    this.width = double.infinity,
    this.height = 50,
    this.edgeRadius = 10,
    this.isBoldText = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed, // Directly calls the action
        style: ElevatedButton.styleFrom(
          elevation: 0,
          side:
              borderColor != null
                  ? BorderSide(color: borderColor!)
                  : BorderSide.none,
          backgroundColor: color ?? AppColors.darkGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(edgeRadius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: isBoldText! ? FontWeight.normal : FontWeight.w600,
            color: textColor ?? AppColors.white,
          ),
        ),
      ),
    );
  }
}

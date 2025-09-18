import 'package:flutter/material.dart';
import 'package:flutter_template/core/constants/app_colors/app_colors.dart';
import 'package:flutter_template/core/util/responsive_util.dart';

class CustomTextFormField extends StatelessWidget {
  final Color? borderColor;
  final Color? backgroundColor;
  final String? label;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final EdgeInsetsGeometry? contentPadding;
  final bool isMandatory;
  final void Function(String)? onChanged;
  final int? maxLength;
  final bool enabled;
  const CustomTextFormField({
    super.key,
    this.label,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.borderColor,
    this.contentPadding,
    this.isMandatory = false,
    this.onChanged,
    this.maxLength,
    this.enabled = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(color: AppColors.black),
              children:
                  isMandatory
                      ? [
                        TextSpan(
                          text: " *",
                          style: TextStyle(color: AppColors.error),
                        ),
                      ]
                      : [],
            ),
          ),
        const SizedBox(height: 8),
        TextFormField(
          enabled: enabled,
          maxLength: maxLength,
          buildCounter:
              (
                context, {
                required currentLength,
                required isFocused,
                required maxLength,
              }) => null,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged, //  Integrated onChanged callback
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.black.withOpacity(0.4), // lighter hint
              fontSize: ResponsiveHelper.getTextSize(context, scale: 0.034),
            ),
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            filled: true,
            fillColor:
                backgroundColor ??
                AppColors.black.withOpacity(0.05), // light grey background
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  borderColor == null
                      ? BorderSide.none
                      : BorderSide(color: borderColor!, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  borderColor == null
                      ? BorderSide.none
                      : BorderSide(color: borderColor!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            prefixIcon:
                keyboardType == TextInputType.phone
                    ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "+91",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    : (prefixIcon != null ? Icon(prefixIcon) : null),
            suffixIcon:
                suffixIcon != null
                    ? IconButton(
                      icon: Icon(suffixIcon),
                      onPressed: onSuffixIconPressed,
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}

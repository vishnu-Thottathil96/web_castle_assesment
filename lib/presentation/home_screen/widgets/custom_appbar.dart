import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/core/constants/app_colors/app_colors.dart';
import 'package:flutter_template/core/constants/app_strings/app_strings.dart';
import 'package:flutter_template/core/constants/asset_paths/app_assets.dart';
import 'package:flutter_template/core/util/responsive_util.dart';
import 'package:flutter_template/presentation/widgets/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBarSection extends StatelessWidget {
  final String username;
  final VoidCallback onNotificationTap;
  final VoidCallback onScanTap;

  const CustomAppBarSection({
    super.key,
    required this.username,
    required this.onNotificationTap,
    required this.onScanTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding:
          ResponsiveHelper.scalePadding(context, horizontal: 15, vertical: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "${AppStrings.greating} , ",
                  style: GoogleFonts.questrial(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: "!"),
                  ],
                ),
              ),
              Image.asset(
                AppAssets.bellIcon,
                height: ResponsiveHelper.scaleHeight(context, 24),
                width: ResponsiveHelper.scaleWidth(context, 24),
              ),
            ],
          ),
          Gap.vertical(context, 26),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          ResponsiveHelper.scaleRadius(context, 41)),
                      border: Border.all(color: AppColors.stroke)),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Search..",
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: AppColors.darkGrey),
                    ),
                  ),
                ),
              ),
              Gap.horizontal(context, 10),
              SizedBox(
                height: ResponsiveHelper.scaleHeight(context, 42),
                child: ElevatedButton.icon(
                  onPressed: onScanTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  icon:
                      const Icon(Icons.qr_code_scanner, color: AppColors.white),
                  label: const Text(
                    "Scan Here",
                    style: TextStyle(
                        color: AppColors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

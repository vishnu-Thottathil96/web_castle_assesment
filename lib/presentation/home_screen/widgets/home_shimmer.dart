import 'package:flutter/material.dart';
import 'package:flutter_template/presentation/widgets/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_template/core/util/responsive_util.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(ResponsiveHelper.scaleWidth(context, 12)),
      children: [
        _bannerShimmer(context, height: 150),
        Gap.vertical(context, 12),
        SizedBox(
          height: ResponsiveHelper.scaleHeight(context, 230),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) =>
                SizedBox(width: ResponsiveHelper.scaleWidth(context, 12)),
            itemBuilder: (context, index) => _productCardShimmer(context),
          ),
        ),
        Gap.vertical(context, 12),
        _bannerShimmer(context, height: 150),
        Gap.vertical(context, 12),
        SizedBox(
          height: ResponsiveHelper.scaleHeight(context, 230),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) =>
                SizedBox(width: ResponsiveHelper.scaleWidth(context, 12)),
            itemBuilder: (context, index) => _productCardShimmer(context),
          ),
        ),
      ],
    );
  }

  Widget _bannerShimmer(BuildContext context, {required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: ResponsiveHelper.scaleHeight(context, height),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(
            ResponsiveHelper.scaleRadius(context, 12),
          ),
        ),
      ),
    );
  }

  Widget _productCardShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: ResponsiveHelper.scaleWidth(context, 165),
        height: ResponsiveHelper.scaleHeight(context, 230),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(
            ResponsiveHelper.scaleRadius(context, 12),
          ),
        ),
      ),
    );
  }
}

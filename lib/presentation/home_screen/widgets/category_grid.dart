import 'package:flutter/material.dart';
import 'package:flutter_template/core/util/responsive_util.dart';
import 'package:flutter_template/presentation/home_screen/widgets/category_item.dart';

class CategoryGrid extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const CategoryGrid({super.key, required this.categories});

  // Predefined background colors
  static const List<Color> _bgColors = [
    Color(0xFFFCF4C4),
    Color(0xFFEBE8FB),
    Color(0xFFFFDCDB),
    Color(0xFFEFFFE4),
  ];

  @override
  Widget build(BuildContext context) {
    if (categories.length > 10) {
      return SizedBox(
        height: ResponsiveHelper.scaleHeight(context, 230),
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final cat = categories[index];
            final bgColor = _bgColors[index % _bgColors.length];
            return CategoryItem(
              imageUrl: cat["image"] ?? "",
              label: cat["name"] ?? "",
              backgroundColor: bgColor,
            );
          },
        ),
      );
    } else {
      //
      return SizedBox(
        height: ResponsiveHelper.scaleHeight(context, 150),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          separatorBuilder: (_, __) =>
              SizedBox(width: ResponsiveHelper.scaleWidth(context, 12)),
          itemBuilder: (context, index) {
            final cat = categories[index];
            final bgColor = _bgColors[index % _bgColors.length];
            return CategoryItem(
              imageUrl: cat["image"] ?? "",
              label: cat["name"] ?? "",
              backgroundColor: bgColor,
            );
          },
        ),
      );
    }
  }
}

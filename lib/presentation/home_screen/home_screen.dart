import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/constants/app_strings/app_strings.dart';
import 'package:flutter_template/core/util/responsive_util.dart';
import 'package:flutter_template/presentation/home_screen/widgets/banner_carousel.dart';
import 'package:flutter_template/presentation/home_screen/widgets/brand_card.dart';
import 'package:flutter_template/presentation/home_screen/widgets/category_grid.dart';
import 'package:flutter_template/presentation/home_screen/widgets/custom_appbar.dart';
import 'package:flutter_template/presentation/home_screen/widgets/heading_row.dart';
import 'package:flutter_template/presentation/home_screen/widgets/home_shimmer.dart';
import 'package:flutter_template/presentation/home_screen/widgets/product_card.dart';
import 'package:flutter_template/presentation/widgets/gap.dart';
import '../../application/home/home_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch home data after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeNotifierProvider.notifier).fetchHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeNotifierProvider);
    final homeFields = homeState.homeFields;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarSection(
              username: AppStrings.demoName,
              onNotificationTap: () {},
              onScanTap: () {},
            ),
            Expanded(
              child: Padding(
                padding: ResponsiveHelper.scalePadding(context, horizontal: 16),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(homeNotifierProvider.notifier).fetchHome();
                  },
                  child: homeState.isLoading
                      ? HomeShimmer()
                      : ListView.builder(
                          itemCount: homeFields.length,
                          itemBuilder: (context, index) {
                            final field = homeFields[index];

                            switch (field.type) {
                              case "carousel":
                                final carouselItems =
                                    (field.raw["carousel_items"] as List?) ??
                                        [];
                                final imageUrls = carouselItems
                                    .map<String>((item) =>
                                        item["image"] as String? ?? '')
                                    .where((url) => url.isNotEmpty)
                                    .toList();

                                if (imageUrls.isEmpty)
                                  return const SizedBox.shrink();

                                return BannerCarousel(imageUrls: imageUrls);

                              case "collection":
                                final products =
                                    (field.raw["products"] as List?) ?? [];
                                if (products.isEmpty)
                                  return const SizedBox.shrink();

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: ResponsiveHelper.scalePadding(
                                          context,
                                          vertical: 8),
                                      child: HeadingRow(
                                        heading:
                                            field.raw["name"] ?? "Collection",
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: products.map((product) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              right:
                                                  ResponsiveHelper.scaleWidth(
                                                      context, 12),
                                            ),
                                            child: ProductCard(
                                              currency: product["currency"]
                                                      .toString()
                                                      .isEmpty
                                                  ? 'AED'
                                                  : product["currency"],
                                              image: product["image"] ?? "",
                                              title: product["name"] ?? "",
                                              price: product["price"]
                                                      ?.toString() ??
                                                  "0",
                                              oldPrice: product["actual_price"]
                                                      ?.toString() ??
                                                  "",
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                );

                              case "brands":
                                final brands =
                                    (field.raw["brands"] as List?) ?? [];
                                if (brands.isEmpty)
                                  return const SizedBox.shrink();

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: ResponsiveHelper.scalePadding(
                                          context,
                                          vertical: 8),
                                      child: HeadingRow(
                                        heading: 'Shop By Brands',
                                      ),
                                    ),
                                    SizedBox(
                                      height: ResponsiveHelper.scaleHeight(
                                          context, 104),
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: brands.length,
                                        separatorBuilder: (_, __) => SizedBox(
                                            width: ResponsiveHelper.scaleWidth(
                                                context, 12)),
                                        itemBuilder: (context, index) {
                                          final brand = brands[index];
                                          return BrandCard(
                                            imageUrl: brand["image"] ?? "",
                                          );
                                        },
                                      ),
                                    ),
                                    Gap.vertical(context, 15)
                                  ],
                                );
                              case "banner":
                                final banner = field.raw["banner"];
                                if (banner == null || banner["image"] == null)
                                  return const SizedBox.shrink();

                                return BannerCarousel(
                                  imageUrls: [banner["image"]],
                                );

                              case "banner-grid":
                                final banners =
                                    (field.raw["banners"] as List?) ?? [];
                                if (banners.isEmpty)
                                  return const SizedBox.shrink();

                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: banners.map((banner) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right: ResponsiveHelper.scaleWidth(
                                              context, 12),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            ResponsiveHelper.scaleRadius(
                                                context, 12),
                                          ),
                                          child: Image.network(
                                            banner["image"] ?? "",
                                            width: ResponsiveHelper.scaleWidth(
                                                context, 165),
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                const SizedBox.shrink(),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                              case "category":
                                final categories =
                                    (field.raw["categories"] as List)
                                        .cast<Map<String, dynamic>>();
                                return Column(
                                  children: [
                                    HeadingRow(
                                      heading: 'Our Categories',
                                    ),
                                    CategoryGrid(categories: categories),
                                  ],
                                );

                              default:
                                return const SizedBox.shrink();
                            }
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

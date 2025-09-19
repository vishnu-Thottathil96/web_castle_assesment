import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/core/constants/app_colors/app_colors.dart';
import 'package:flutter_template/core/util/responsive_util.dart';
import 'package:flutter_template/presentation/home_screen/widgets/banner_carousel.dart';
import 'package:flutter_template/presentation/home_screen/widgets/brand_card.dart';
import 'package:flutter_template/presentation/home_screen/widgets/category_grid.dart';
import 'package:flutter_template/presentation/home_screen/widgets/custom_appbar.dart';
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
              username: 'James',
              onNotificationTap: () {},
              onScanTap: () {},
            ),
            Expanded(
              child: Padding(
                padding: ResponsiveHelper.scalePadding(context, horizontal: 16),
                child: homeState.isLoading
                    ? HomeShimmer()
                    : ListView.builder(
                        itemCount: homeFields.length,
                        itemBuilder: (context, index) {
                          final field = homeFields[index];

                          switch (field.type) {
                            case "carousel":
                              final carouselItems =
                                  (field.raw["carousel_items"] as List?) ?? [];
                              final imageUrls = carouselItems
                                  .map<String>(
                                      (item) => item["image"] as String? ?? '')
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          field.raw["name"] ?? "Collection",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.black),
                                        ),
                                        Text(
                                          'view All',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      AppColors.black,
                                                  color: AppColors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: products.map((product) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            right: ResponsiveHelper.scaleWidth(
                                                context, 12),
                                          ),
                                          child: ProductCard(
                                            image: product["image"] ?? "",
                                            title: product["name"] ?? "",
                                            price:
                                                product["price"]?.toString() ??
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Shop By Brands",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.black),
                                        ),
                                        Text(
                                          'view All',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      AppColors.black,
                                                  color: AppColors.black),
                                        ),
                                      ],
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
                                              const Icon(Icons.broken_image),
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
                              return CategoryGrid(categories: categories);

                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////
// ListView(
//                   children: [
//                     BannerCarousel(imageUrls: [
//                       "https://s419.previewbay.com/fragrance-b2b-backend/public/storage/cms/banner-grid/xMLTL7iQ0LKeljQiIf26GXibe8sRqAPTpIvaAmvK.jpg",
//                       "https://s419.previewbay.com/fragrance-b2b-backend/public/storage/cms/banner-grid/dtTLimXx1NEknSLgK2MVmDAKAXp05Hzw4syK6q8B.jpg",
//                     ]),
//                     Center(
//                       child: ProductCard(
//                         image:
//                             'https://s419.previewbay.com/fragrance-b2b-backend/public/storage/medias/FW0002.jpg',
//                         oldPrice: '500',
//                         price: '555',
//                         title: 'titkee',
//                       ),
//                     ),
//                     BannerCarousel(imageUrls: [
//                       "https://s419.previewbay.com/fragrance-b2b-backend/public/storage/cms/banner-grid/xMLTL7iQ0LKeljQiIf26GXibe8sRqAPTpIvaAmvK.jpg",
//                       "https://s419.previewbay.com/fragrance-b2b-backend/public/storage/cms/banner-grid/dtTLimXx1NEknSLgK2MVmDAKAXp05Hzw4syK6q8B.jpg",
//                     ]),
//                     SizedBox(
//                       height: ResponsiveHelper.scaleHeight(context, 230),
//                       child: GridView.count(
//                         crossAxisCount: 2, // 2 rows
//                         scrollDirection:
//                             Axis.horizontal, // horizontal scrolling
//                         shrinkWrap: true,
//                         children: [
//                           CategoryItem(
//                             imageUrl: "https://picsum.photos/200",
//                             label: "Citrus",
//                             backgroundColor: Colors.yellow.shade100,
//                           ),
//                           CategoryItem(
//                             imageUrl: "https://picsum.photos/201",
//                             label: "Aromatic",
//                             backgroundColor: Colors.purple.shade100,
//                           ),
//                           CategoryItem(
//                             imageUrl: "https://picsum.photos/202",
//                             label: "Floral",
//                             backgroundColor: Colors.pink.shade100,
//                           ),
//                           CategoryItem(
//                             imageUrl: "https://picsum.photos/203",
//                             label: "Green",
//                             backgroundColor: Colors.green.shade100,
//                           ),
//                           CategoryItem(
//                             imageUrl: "https://picsum.photos/204",
//                             label: "Woody",
//                             backgroundColor: Colors.brown.shade100,
//                           ),
//                           CategoryItem(
//                             imageUrl: "https://picsum.photos/205",
//                             label: "Oriental",
//                             backgroundColor: Colors.orange.shade100,
//                           ),
//                           CategoryItem(
//                             imageUrl: "https://picsum.photos/206",
//                             label: "Fresh",
//                             backgroundColor: Colors.blue.shade100,
//                           ),
//                           CategoryItem(
//                             imageUrl: "https://picsum.photos/207",
//                             label: "Fruity",
//                             backgroundColor: Colors.red.shade100,
//                           ),
//                           CategoryItem(
//                             imageUrl: "https://picsum.photos/207",
//                             label: "Fruity",
//                             backgroundColor: Colors.red.shade100,
//                           ),
//                           CategoryItem(
//                             imageUrl: "https://picsum.photos/207",
//                             label: "Fruity",
//                             backgroundColor: Colors.red.shade100,
//                           ),
//                           CategoryItem(
//                             imageUrl: "https://picsum.photos/207",
//                             label: "Fruity",
//                             backgroundColor: Colors.red.shade100,
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 )

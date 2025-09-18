import 'package:flutter/material.dart';
import 'package:flutter_template/core/util/responsive_util.dart';
import 'package:flutter_template/presentation/home_screen/widgets/banner_carousel.dart';
import 'package:flutter_template/presentation/home_screen/widgets/category_item.dart';
import 'package:flutter_template/presentation/home_screen/widgets/custom_appbar.dart';
import 'package:flutter_template/presentation/home_screen/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarSection(
              username: 'James',
              onNotificationTap: () {
                // Handle notification tap
              },
              onScanTap: () {
                // Handle scan tap
              },
            ),
            Expanded(
              child: Padding(
                padding: ResponsiveHelper.scalePadding(context, horizontal: 18),
                child: ListView(
                  children: [
                    BannerCarousel(imageUrls: [
                      "https://s419.previewbay.com/fragrance-b2b-backend/public/storage/cms/banner-grid/xMLTL7iQ0LKeljQiIf26GXibe8sRqAPTpIvaAmvK.jpg",
                      "https://s419.previewbay.com/fragrance-b2b-backend/public/storage/cms/banner-grid/dtTLimXx1NEknSLgK2MVmDAKAXp05Hzw4syK6q8B.jpg",
                    ]),
                    Center(
                      child: ProductCard(
                        image:
                            'https://s419.previewbay.com/fragrance-b2b-backend/public/storage/medias/FW0002.jpg',
                        oldPrice: '500',
                        price: '555',
                        title: 'titkee',
                      ),
                    ),
                    BannerCarousel(imageUrls: [
                      "https://s419.previewbay.com/fragrance-b2b-backend/public/storage/cms/banner-grid/xMLTL7iQ0LKeljQiIf26GXibe8sRqAPTpIvaAmvK.jpg",
                      "https://s419.previewbay.com/fragrance-b2b-backend/public/storage/cms/banner-grid/dtTLimXx1NEknSLgK2MVmDAKAXp05Hzw4syK6q8B.jpg",
                    ]),
                    SizedBox(
                      height: ResponsiveHelper.scaleHeight(context, 230),
                      child: GridView.count(
                        crossAxisCount: 2, // 2 rows
                        scrollDirection:
                            Axis.horizontal, // horizontal scrolling
                        shrinkWrap: true,
                        children: [
                          CategoryItem(
                            imageUrl: "https://picsum.photos/200",
                            label: "Citrus",
                            backgroundColor: Colors.yellow.shade100,
                          ),
                          CategoryItem(
                            imageUrl: "https://picsum.photos/201",
                            label: "Aromatic",
                            backgroundColor: Colors.purple.shade100,
                          ),
                          CategoryItem(
                            imageUrl: "https://picsum.photos/202",
                            label: "Floral",
                            backgroundColor: Colors.pink.shade100,
                          ),
                          CategoryItem(
                            imageUrl: "https://picsum.photos/203",
                            label: "Green",
                            backgroundColor: Colors.green.shade100,
                          ),
                          CategoryItem(
                            imageUrl: "https://picsum.photos/204",
                            label: "Woody",
                            backgroundColor: Colors.brown.shade100,
                          ),
                          CategoryItem(
                            imageUrl: "https://picsum.photos/205",
                            label: "Oriental",
                            backgroundColor: Colors.orange.shade100,
                          ),
                          CategoryItem(
                            imageUrl: "https://picsum.photos/206",
                            label: "Fresh",
                            backgroundColor: Colors.blue.shade100,
                          ),
                          CategoryItem(
                            imageUrl: "https://picsum.photos/207",
                            label: "Fruity",
                            backgroundColor: Colors.red.shade100,
                          ),
                          CategoryItem(
                            imageUrl: "https://picsum.photos/207",
                            label: "Fruity",
                            backgroundColor: Colors.red.shade100,
                          ),
                          CategoryItem(
                            imageUrl: "https://picsum.photos/207",
                            label: "Fruity",
                            backgroundColor: Colors.red.shade100,
                          ),
                          CategoryItem(
                            imageUrl: "https://picsum.photos/207",
                            label: "Fruity",
                            backgroundColor: Colors.red.shade100,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

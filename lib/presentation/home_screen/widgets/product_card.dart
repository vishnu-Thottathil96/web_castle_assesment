import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/core/constants/app_colors/app_colors.dart';
import 'package:flutter_template/core/util/responsive_util.dart';
import 'package:flutter_template/presentation/widgets/gap.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String oldPrice;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = ResponsiveHelper.scaleWidth(context, 165);

    return Column(
      children: [
        Container(
          width: cardWidth,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(
                ResponsiveHelper.scaleRadius(context, 12)),
            border: Border.all(color: AppColors.stroke, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Discount and Favorite icon
              Gap.vertical(context, 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: ResponsiveHelper.scaleHeight(context, 20),
                    width: ResponsiveHelper.scaleWidth(context, 64),
                    decoration: BoxDecoration(
                      color: AppColors.paleGrey,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                            ResponsiveHelper.scaleRadius(context, 20)),
                        bottomRight: Radius.circular(
                            ResponsiveHelper.scaleRadius(context, 20)),
                      ),
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "40% OFF",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGreen,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          right: ResponsiveHelper.scaleWidth(context, 8)),
                      child: FavoriteIcon()),
                ],
              ),

              /// Product Image
              Center(
                  child: Image.network(
                height: ResponsiveHelper.scaleHeight(context, 100),
                width: ResponsiveHelper.scaleWidth(context, 100),
                image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.image,
                  size: 100.sp,
                  color: Colors.grey.shade300,
                ),
              )),
              Gap.vertical(context, 8),

              /// Title
              Padding(
                padding: ResponsiveHelper.scalePadding(context, horizontal: 10),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ),
              Gap.vertical(context, 14),

              /// Price Section
              Padding(
                padding: ResponsiveHelper.scalePadding(context, horizontal: 8),
                child: Text(
                  'AED$oldPrice',
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.darkGrey,
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: ResponsiveHelper.scaleHeight(context, 4)),

              Padding(
                padding: ResponsiveHelper.scalePadding(context, horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      'AED $price',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      " per Dozen",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Gap.vertical(context, 15),

              Padding(
                padding: ResponsiveHelper.scalePadding(context, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: ResponsiveHelper.scaleHeight(context, 34),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ResponsiveHelper.scaleRadius(context, 14)),
                          border: Border.all(color: AppColors.stroke),
                        ),
                        child: Padding(
                          padding: ResponsiveHelper.scalePadding(context,
                              horizontal: 5),
                          child: Text(
                            "RFQ",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.scaleWidth(context, 8)),

                    /// Add to Cart button-like container
                    Expanded(
                      flex: 5,
                      child: AddToCartButton(),
                    ),
                  ],
                ),
              ),
              Gap.vertical(context, 15),
            ],
          ),
        ),
        Gap.vertical(context, 15)
      ],
    );
  }
}

/////

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({super.key});

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (count == 0) {
          setState(() => count = 1);
        }
      },
      child: Container(
        height: ResponsiveHelper.scaleHeight(context, 34),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius:
              BorderRadius.circular(ResponsiveHelper.scaleRadius(context, 14)),
        ),
        padding:
            ResponsiveHelper.scalePadding(context, vertical: 10, horizontal: 8),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: count == 0
              ? Text(
                  "Add to Cart",
                  key: const ValueKey("add"),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              : FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    key: const ValueKey("counter"),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (count > 1) {
                              count--;
                            } else {
                              count = 0; // back to "Add to Cart"
                            }
                          });
                        },
                        child: const Icon(Icons.remove,
                            color: Colors.white, size: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          "$count",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => count++),
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
////

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({super.key});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => isSelected = !isSelected);
      },
      child: Icon(
        isSelected ? Icons.favorite : Icons.favorite_border,
        size: 20.sp,
        color: isSelected ? AppColors.error : AppColors.black,
      ),
    );
  }
}

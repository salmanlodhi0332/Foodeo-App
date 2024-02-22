import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/screens/addproduct/view/product_detail_screen.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class popularproductCard extends StatelessWidget {
  final String image;
  final String name;
  final String distance;
  final String rating;
  final String reviewsCount;
  final String price;
  final String deliverycharges;
  final String restaurantImage;
  final String deliveryRadius;
  const popularproductCard({
    super.key,
    required this.image,
    required this.name,
    required this.distance,
    required this.rating,
    required this.reviewsCount,
    required this.price,
    required this.deliverycharges,
    required this.restaurantImage,
    required this.deliveryRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
      builder: (themeController) => AnnotatedRegion(
        value: themeController.systemUiOverlayStyleForwhite,
        child: SpringWidget(
          onTap: () {
            // Navigation.getInstance.RightToLeft_PageNavigation(context, ProductDetailScreen(productId: productId, reelId: reelId))
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: themeController.colorwhite,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ImageWidget(
                          imageUrl: image,
                          height: 90.sp,
                          width: 80.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              FittedBox(
                                fit: BoxFit.cover,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                        color: themeController.textcolor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('$distance km'),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text('$rating ($reviewsCount)'),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                fit: BoxFit.cover,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/delivery.svg",
                                      height: 15.sp,
                                      color: themeController.colorPrimary,
                                    ),
                                    Text('$deliveryRadius km'),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: themeController.colorPrimary,
                                radius: 10.sp,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: ImageWidget(
                                      imageUrl: restaurantImage,
                                      height: 30,
                                      width: 30,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

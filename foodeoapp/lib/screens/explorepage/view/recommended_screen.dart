import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/screens/addproduct/view/product_detail_screen.dart';
import 'package:foodeoapp/screens/explorepage/viewModel/explore_view_model.dart';
import 'package:foodeoapp/screens/explorepage/widget/popularproductcard.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class RecommendedScreen extends StatelessWidget {
  RecommendedScreen({super.key});

  @override
  final RecommendedController = Get.put(ExploreViewModel());
  Widget build(BuildContext context) {
    RecommendedController.getRecommendedProductData();
    return GetBuilder<ThemeHelper>(
        builder: (themeController) => AnnotatedRegion(
              value: themeController.systemUiOverlayStyleForwhite,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: themeController.bgcolor,
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.screenPadding),
                      child: Column(
                        children: [
                          CustomAppBar(
                            appbarpadding: false,
                            leading: () {
                              Navigator.pop(context);
                            },
                            title: Text(
                              'Recommended',
                              style: TextStyle(
                                  color: themeController.textcolor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          ...RecommendedController.PopularProductPageList.map(
                              (e) => SpringWidget(
                                    onTap: () {
                                      Navigation.getInstance.screenNavigation(
                                          context,
                                          ProductDetailScreen(
                                            productId: e.productId,
                                          ));
                                    },
                                    child: popularproductCard(
                                        image: e.productImage,
                                        name: e.productName,
                                        distance: e.deliveryRadius,
                                        rating: e.ratingsAverage,
                                        reviewsCount: e.reviewsCount,
                                        price: e.productPrice,
                                        deliverycharges: e.deliveryCharges,
                                        restaurantImage: e.restaurantImage,
                                        deliveryRadius: e.deliveryRadius),
                                  )).toList()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}

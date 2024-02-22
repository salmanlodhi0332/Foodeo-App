import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/screens/explorepage/viewModel/explore_view_model.dart';
import 'package:foodeoapp/screens/explorepage/widget/popularproductcard.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SearchProductScreen extends StatelessWidget {
  SearchProductScreen({super.key});

  @override
  final SearchController = TextEditingController();
  final Explorecontroller = Get.put(ExploreViewModel());
  Widget build(BuildContext context) {
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
                              'Explore',
                              style: TextStyle(
                                  color: themeController.textcolor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          CustomTextFieldWidget(
                              icon: Icon(
                                Icons.search,
                                color:
                                    themeController.colorIcon.withOpacity(0.4),
                              ),
                              fieldColor: themeController.colorwhite,
                              controller: SearchController,
                              hintText: 'search Product..',
                              onchange: (value) {},
                              onsubmit: () {
                                Explorecontroller.getSearchProduct(
                                    SearchController.text);
                              },
                              inputType: TextInputType.name,
                              label: '',
                              enabled: true),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Obx(
                            () => Container(
                              height: double.maxFinite,
                              child: ListView.builder(
                                itemCount: Explorecontroller.SaerchList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return popularproductCard(
                                      image: Explorecontroller
                                          .SaerchList[index].productImage,
                                      name: Explorecontroller
                                          .SaerchList[index].productName,
                                      distance: Explorecontroller
                                          .SaerchList[index].deliveryRadius,
                                      rating: Explorecontroller
                                          .SaerchList[index].ratingsAverage,
                                      reviewsCount: Explorecontroller
                                          .SaerchList[index].reviewsCount,
                                      price: Explorecontroller
                                          .SaerchList[index].productPrice,
                                      deliverycharges: Explorecontroller
                                          .SaerchList[index].deliveryCharges,
                                      restaurantImage: Explorecontroller
                                          .SaerchList[index].restaurantImage,
                                      deliveryRadius: Explorecontroller
                                          .SaerchList[index].deliveryRadius);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';
import '../viewmodel/my_order_view_model.dart';

class AddReviewScreen extends StatelessWidget {
  final int productId;
  AddReviewScreen({
    required this.productId,
    super.key,
  });
  final controller = Get.put(MyOrderViewModel());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
      builder: (themeController) => AnnotatedRegion(
        value: themeController.systemUiOverlayStyleForPrimary,
        child: Scaffold(
          backgroundColor: Colors.red,
          body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: themeController.screenGradient,
              ),
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
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              "Rate us & Give feedback ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  color: themeController.textcolor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.sp),
                              child: Center(
                                child: RatingBar.builder(
                                  initialRating: 2,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    log('${rating}');
                                    controller.orderRating.value = rating;
                                    log('${controller.orderRating.value}');
                                  },
                                ),
                              )),
                          Obx(() => Container(
                                padding: EdgeInsets.all(15.sp),
                                decoration: BoxDecoration(
                                  color: themeController.colorwhite
                                      .withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(32),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: Offset(1.0, 1))
                                  ],
                                ),
                                child: Form(
                                  key: _formkey,
                                  child: TextFormField(
                                    controller:
                                        controller.reviewcontroller.value,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 13,
                                    style: TextStyle(
                                      color: themeController.textcolor,
                                      fontSize: 14,
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(RegExp(
                                          r'\s\s+')), // Deny consecutive spaces
                                      LeadingSpaceTrimmerInputFormatter(), // Custom input formatter to trim leading spaces
                                    ],
                                    validator: (input) => input!.length < 10
                                        ? 'please enter at least 10 characters'
                                        : input.length > 200
                                            ? 'please enter only 200'
                                            : null,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          "Give us your feedback here.....",
                                      hintStyle: TextStyle(
                                        color: themeController.textcolor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Obx(() => RoundButton(
                        loading: controller.loading.value,
                        backgroundColor: themeController.colorPrimary,
                        textColor: themeController.colorwhite,
                        height: 45.sp,
                        title: "Submit",
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            controller.postOrderReview(
                                productId,
                                controller.reviewcontroller.value.text,
                                controller.orderRating.value);
                          }
                        }))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class LeadingSpaceTrimmerInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Trim leading spaces from the text value
    if (newValue.text.startsWith(' ')) {
      final trimmedText = newValue.text.trimLeft();
      return newValue.copyWith(
        text: trimmedText,
        composing: TextRange.collapsed(trimmedText.length),
      );
    }
    return newValue;
  }
}

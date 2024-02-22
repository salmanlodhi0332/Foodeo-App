import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';
import '../../../components/round_button.dart';
import '../view_model/auth_view_model.dart';

class PhoneAuthScreen extends StatelessWidget {
  PhoneAuthScreen({super.key});

  final controller = Get.put(AuthViewModel());

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForAuth,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.screenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: SvgPicture.asset(
                          'assets/icons/foodeo.svg',
                          width: 70.sp,
                          height: 75.sp,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Constants.screenPadding),
                        child: Text(
                          'Watch, Order, Enjoy',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: themecontroller.textcolor),
                        ),
                      ),
                      Form(
                        key: _formkey,
                        child: CustomTextFieldWidget(
                          enabled: true,
                          label: 'Phone Number',
                          controller: controller.phoneNumber.value,
                          hintText: "Enter phone number",
                          inputType: TextInputType.phone,
                          focusNode: controller
                              .phoneNumberFocusNode, // Pass the FocusNode here
                          onsubmit: () {},
                          onchange: (value) {
                            // apihitting = true;
                          },
                          validator: (input) => input!.length < 3
                              ? 'please enter at least 3 characters'
                              : input.length > 20
                                  ? 'please enter only 20'
                                  : null,
                        ),
                      ),
                      SizedBox(height: 35.sp),
                      Obx(() => RoundButton(
                            gradient: true,
                            margin: 0,
                            backgroundColor: themecontroller.colorPrimary,
                            height: 60.sp,
                            loading: controller.loading.value,
                            onTap: () {
                              print(
                                  '${controller.phoneNumber.value.text.toString()}');
                              if (_formkey.currentState!.validate()) {
                                controller.mobileOtpSend(
                                    controller.phoneNumber.value.text
                                        .toString(),
                                    context);
                              }
                            },
                            title: 'Sign in',
                            iconColor: themecontroller.colorwhite,
                            textColor: themecontroller.colorwhite,
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.screenPadding),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                        color: themecontroller.textcolor.withOpacity(0.5),
                        fontSize: 11.sp),
                    children: const <TextSpan>[
                      TextSpan(
                        text:
                            'By taping Continue with email, Google or Apple or by continue',
                      ),
                      TextSpan(
                        text:
                            'as a guest , you agree to Foodeo’s Terms & conditions',
                      ),
                      TextSpan(
                        text: 'and Privacy policy.',
                      ),
                    ],
                  ),
                ),
              ),
              // Text(
              //   'Lorem ipsum is a placeholder text commonly used to demonstrate ocument or a typeface without relying on meaningful content',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //       color: themecontroller.textcolor.withOpacity(0.5),
              //       fontSize: 11.sp),
              // ),
              const SizedBox(height: Constants.screenPadding),
            ],
          ),
        ),
      );
    });
  }
}

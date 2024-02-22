import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/screens/authentication/view_model/auth_view_model.dart';
import 'package:get/get.dart';
import '../../../components/round_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../helper/internet_controller.dart';
import '../../../helper/internet_screen.dart';
import 'login_with_email.dart';
import 'phone_auth_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final controller = Get.put(AuthViewModel());

  final internetController = Get.put(InternetController());

  List imagelist = [
    'assets/images/food1.jpg',
    'assets/images/food2.jpg',
    'assets/images/food3.jpg',
    'assets/images/food4.jpg',
    'assets/images/food6.jpg',
    'assets/images/food5.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForAuth,
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Constants.screenPadding),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 300.sp,
                      color: const Color(0xfff2f4f7),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CarouselSlider(
                                    items: imagelist.map((imagePath) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: Image.asset(
                                                imagePath,
                                                height: 190,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                    options: CarouselOptions(
                                      height: 300.sp,
                                      aspectRatio: 16 / 12,
                                      viewportFraction: 0.6,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(milliseconds: 1000),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 1800),
                                      autoPlayCurve: Curves.linearToEaseOut,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.vertical,
                                    )),
                              ),
                              Expanded(
                                child: CarouselSlider(
                                    items: imagelist.map((imagePath) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: Image.asset(
                                                imagePath,
                                                height: 190,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                    options: CarouselOptions(
                                      height: 270.sp,
                                      aspectRatio: 16 / 12,
                                      viewportFraction: 0.6,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: true,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(milliseconds: 1500),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 2000),
                                      autoPlayCurve: Curves.linearToEaseOut,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.vertical,
                                    )),
                              ),
                              Expanded(
                                child: CarouselSlider(
                                    items: imagelist.map((imagePath) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: Image.asset(
                                                imagePath,
                                                height: 190,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                    options: CarouselOptions(
                                      height: 290.sp,
                                      aspectRatio: 16 / 12,
                                      viewportFraction: 0.6,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(milliseconds: 1000),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 1800),
                                      autoPlayCurve: Curves.linearToEaseOut,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.vertical,
                                    )),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 200.sp,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.white.withOpacity(0.7),
                                    Colors.white30,
                                    Colors.white12,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.sp),
                      child: SvgPicture.asset(
                        'assets/icons/foodeo.svg',
                        width: 70.sp,
                        height: 75.sp,
                      ),
                    ),
                    SizedBox(height: 12.sp),
                    Text(
                      'Watch, Order, Enjoy',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: themecontroller.textcolor),
                    ),
                    SizedBox(height: 12.sp),
                    RoundButton(
                      gradient: true,
                      margin: 0,
                      backgroundColor: themecontroller.colorPrimary,
                      height: 60.sp,
                      onTap: () {
                        Navigation.getInstance
                            .screenNavigation(context, PhoneAuthScreen());
                      },
                      icon: 'assets/icons/phone.svg',
                      title: 'Continue with phone',
                      iconColor: themecontroller.colorwhite,
                      textColor: themecontroller.colorwhite,
                    ),
                    SizedBox(height: 12.sp),
                    RoundButton(
                      gradient: true,
                      margin: 0,
                      backgroundColor: themecontroller.colorPrimary,
                      height: 60.sp,
                      onTap: () {
                        // controller.registration.value = false;
                        Navigation.getInstance
                            .screenNavigation(context, LoginWithEmail());
                      },
                      icon: 'assets/icons/email.svg',
                      title: 'Continue with Email',
                      iconColor: themecontroller.colorwhite,
                      textColor: themecontroller.colorwhite,
                    ),
                    SizedBox(height: 12.sp),
                    Obx(() => RoundButton(
                          margin: 0,
                          borderColor: themecontroller.disablecolor,
                          loading: controller.processingGoogle.value,
                          disabled: controller.processing.value,
                          height: 58.sp,
                          icon: 'assets/icons/google.svg',
                          onTap: () {
                            log('object  123');
                            controller.signUpWithGoogle(context);
                          },
                          title: 'Continue with google',
                          textColor: themecontroller.textcolor,
                        )),
                    SizedBox(height: 20.sp),

                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 12.sp),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Expanded(
                    //         child: Divider(
                    //           color: themecontroller.textcolor.withOpacity(0.5),
                    //           thickness: 1,
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 5),
                    //         child: Text(
                    //           'or',
                    //           style: TextStyle(
                    //               color: themecontroller.textcolor
                    //                   .withOpacity(0.5),
                    //               fontSize: 18.sp),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Divider(
                    //           color: themecontroller.textcolor.withOpacity(0.5),
                    //           thickness: 1,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigation.getInstance.RightToLeft_PageNavigation(
                    //         context, RegisterScreen());
                    //   },
                    //   child: RichText(
                    //     textAlign: TextAlign.right,
                    //     text: TextSpan(
                    //         style: TextStyle(
                    //           fontSize: 12,
                    //           color: themecontroller.colorPrimary,
                    //         ),
                    //         children: [
                    //           TextSpan(
                    //             text: "if you havn't account ",
                    //             style: TextStyle(
                    //                 fontSize: 10.sp,
                    //                 fontWeight: FontWeight.w600),
                    //           ),
                    //           TextSpan(
                    //             text: "SignUp?",
                    //             style: TextStyle(
                    //               decoration: TextDecoration.underline,
                    //               fontSize: 12.sp,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //         ]),
                    //   ),
                    // ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.sp),
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
              ],
            ),
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';
import '../../../components/round_button.dart';
import '../view_model/auth_view_model.dart';

// ignore: must_be_immutable
class VerifyOtpScreen extends StatelessWidget {
  final String phoneNumber;
  final String verfiyId;
  VerifyOtpScreen(
      {super.key, required this.phoneNumber, required this.verfiyId});

  final controller = Get.put(AuthViewModel());
  FocusNode noteFocusNode = FocusNode();

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    controller.startTimer();
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
                      // Container(
                      //   height: 370,
                      //   color: const Color(0xfff2f4f7),
                      //   child: Stack(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: CarouselSlider(
                      //                 items: imagelist.map((imagePath) {
                      //                   return Builder(
                      //                     builder: (BuildContext context) {
                      //                       return Container(
                      //                         margin:
                      //                             const EdgeInsets.symmetric(
                      //                                 horizontal: 5),
                      //                         decoration: BoxDecoration(
                      //                           color: Colors.transparent,
                      //                           borderRadius:
                      //                               BorderRadius.circular(25),
                      //                         ),
                      //                         child: ClipRRect(
                      //                           borderRadius:
                      //                               BorderRadius.circular(25),
                      //                           child: Image.asset(
                      //                             imagePath,
                      //                             height: 190,
                      //                             fit: BoxFit.cover,
                      //                           ),
                      //                         ),
                      //                       );
                      //                     },
                      //                   );
                      //                 }).toList(),
                      //                 options: CarouselOptions(
                      //                   height: 260.sp,
                      //                   aspectRatio: 16 / 12,
                      //                   viewportFraction: 0.6,
                      //                   initialPage: 0,
                      //                   enableInfiniteScroll: true,
                      //                   reverse: false,
                      //                   autoPlay: true,
                      //                   autoPlayInterval:
                      //                       const Duration(milliseconds: 1000),
                      //                   autoPlayAnimationDuration:
                      //                       const Duration(milliseconds: 1800),
                      //                   autoPlayCurve: Curves.linearToEaseOut,
                      //                   enlargeCenterPage: true,
                      //                   scrollDirection: Axis.vertical,
                      //                 )),
                      //           ),
                      //           Expanded(
                      //             child: CarouselSlider(
                      //                 items: imagelist.map((imagePath) {
                      //                   return Builder(
                      //                     builder: (BuildContext context) {
                      //                       return Container(
                      //                         margin:
                      //                             const EdgeInsets.symmetric(
                      //                                 horizontal: 5),
                      //                         decoration: BoxDecoration(
                      //                           color: Colors.transparent,
                      //                           borderRadius:
                      //                               BorderRadius.circular(25),
                      //                         ),
                      //                         child: ClipRRect(
                      //                           borderRadius:
                      //                               BorderRadius.circular(25),
                      //                           child: Image.asset(
                      //                             imagePath,
                      //                             height: 190,
                      //                             fit: BoxFit.cover,
                      //                           ),
                      //                         ),
                      //                       );
                      //                     },
                      //                   );
                      //                 }).toList(),
                      //                 options: CarouselOptions(
                      //                   height: 260.sp,
                      //                   aspectRatio: 16 / 12,
                      //                   viewportFraction: 0.6,
                      //                   initialPage: 0,
                      //                   enableInfiniteScroll: true,
                      //                   reverse: true,
                      //                   autoPlay: true,
                      //                   autoPlayInterval:
                      //                       const Duration(milliseconds: 1500),
                      //                   autoPlayAnimationDuration:
                      //                       const Duration(milliseconds: 2000),
                      //                   autoPlayCurve: Curves.linearToEaseOut,
                      //                   enlargeCenterPage: true,
                      //                   scrollDirection: Axis.vertical,
                      //                 )),
                      //           ),
                      //           Expanded(
                      //             child: CarouselSlider(
                      //                 items: imagelist.map((imagePath) {
                      //                   return Builder(
                      //                     builder: (BuildContext context) {
                      //                       return Container(
                      //                         margin:
                      //                             const EdgeInsets.symmetric(
                      //                                 horizontal: 5),
                      //                         decoration: BoxDecoration(
                      //                           color: Colors.transparent,
                      //                           borderRadius:
                      //                               BorderRadius.circular(25),
                      //                         ),
                      //                         child: ClipRRect(
                      //                           borderRadius:
                      //                               BorderRadius.circular(25),
                      //                           child: Image.asset(
                      //                             imagePath,
                      //                             height: 190,
                      //                             fit: BoxFit.cover,
                      //                           ),
                      //                         ),
                      //                       );
                      //                     },
                      //                   );
                      //                 }).toList(),
                      //                 options: CarouselOptions(
                      //                   height: 260.sp,
                      //                   aspectRatio: 16 / 12,
                      //                   viewportFraction: 0.6,
                      //                   initialPage: 0,
                      //                   enableInfiniteScroll: true,
                      //                   reverse: false,
                      //                   autoPlay: true,
                      //                   autoPlayInterval:
                      //                       const Duration(milliseconds: 1000),
                      //                   autoPlayAnimationDuration:
                      //                       const Duration(milliseconds: 1800),
                      //                   autoPlayCurve: Curves.linearToEaseOut,
                      //                   enlargeCenterPage: true,
                      //                   scrollDirection: Axis.vertical,
                      //                 )),
                      //           ),
                      //         ],
                      //       ),
                      //       Align(
                      //         alignment: Alignment.bottomCenter,
                      //         child: Container(
                      //           height: 150.sp,
                      //           decoration: BoxDecoration(
                      //             gradient: LinearGradient(
                      //               begin: Alignment.bottomCenter,
                      //               end: Alignment.topCenter,
                      //               colors: [
                      //                 Colors.white.withOpacity(0.7),
                      //                 Colors.white30,
                      //                 Colors.white12,
                      //                 Colors.transparent,
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

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
                          label: 'Verify OTP',

                          controller: controller.verifyotp.value,
                          hintText: "Enter OTP",
                          inputType: TextInputType.phone,
                          focusNode: noteFocusNode, // Pass the FocusNode here
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

                      SizedBox(height: 20.sp),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              controller.countdown == 0
                                  ? TextButton(
                                      onPressed: () {
                                        controller.sendNewCode(phoneNumber);
                                      },
                                      child:
                                          controller.toastloading.value == true
                                              ? SmallLoader()
                                              : Text('Resend Code',
                                                  style: TextStyle(
                                                      color: themecontroller
                                                          .colorPrimary,
                                                      fontSize: 12.sp)))
                                  : Text(
                                      'Resend code in ',
                                      style: TextStyle(
                                          color: themecontroller.textcolor,
                                          fontSize: 12.sp),
                                    ),
                              Text(
                                  controller.countdown == 0
                                      ? ''
                                      : controller.countdown.toString() + 's',
                                  style: TextStyle(
                                      color: themecontroller.colorPrimary,
                                      fontSize: 12.sp)),
                            ],
                          )),
                      SizedBox(height: 20.sp),
                      Obx(
                        () => RoundButton(
                          gradient: true,
                          margin: 0,
                          backgroundColor: themecontroller.colorPrimary,
                          height: 60.sp,
                          loading: controller.loading.value,
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              controller.otpVerification(
                                  context, verfiyId, phoneNumber);
                            }
                            // Navigation.getInstance.Page_PushAndReplaceNavigation(
                            //     context, VideoReelsScreen());
                          },
                          // icon: 'assets/icons/phone.svg',
                          title: 'Verfiy',
                          textColor: themecontroller.colorwhite,
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: Constants.screenPadding),
                      //   child: RoundButton(
                      //     margin: 0,
                      //     borderColor: themecontroller.disablecolor,
                      //     height: 58.sp,
                      //     // icon: 'assets/icons/google.svg',
                      //     onTap: () {
                      //       log('object  123');
                      //       // NutrientBottomSheet.show(context);
                      //     },
                      //     title: 'As a Restaurant',
                      //     textColor: themecontroller.textcolor,
                      //   ),
                      // ),
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

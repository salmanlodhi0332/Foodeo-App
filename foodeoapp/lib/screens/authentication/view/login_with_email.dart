import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';
import '../../../components/round_button.dart';
import '../../../constant/flutter_toast.dart';
import '../../../helper/internet_controller.dart';
import '../view_model/auth_view_model.dart';

class LoginWithEmail extends StatelessWidget {
  LoginWithEmail({super.key});
  final controller = Get.put(AuthViewModel());

  final internetController = Get.put(InternetController());

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForAuth,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                      SizedBox(height: 25.sp),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            CustomTextFieldWidget(
                              enabled: true,
                              label: 'Email',
                              controller: controller.emailController.value,
                              hintText: "Enter email",
                              inputType: TextInputType.emailAddress,
                              focusNode: controller
                                  .emailFocusNode, // Pass the FocusNode here
                              onsubmit: () {},
                              onchange: (value) {
                                // apihitting = true;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email address';
                                }
                                const emailPattern =
                                    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$';
                                if (!RegExp(emailPattern).hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12.sp),
                            Obx(() => CustomTextFieldWidget(
                                  enabled: true,
                                  label: 'Password',
                                  controller:
                                      controller.passwordController.value,
                                  hintText: "Enter password",
                                  inputType: TextInputType.visiblePassword,
                                  obscureText: controller.hidepassword.value,
                                  focusNode: controller.passwordFocusNode,
                                  onsubmit: () {},
                                  onchange: (value) {
                                    // apihitting = true;
                                  },
                                  validator: (input) => input!.length < 3
                                      ? 'Please enter at least 3 characters'
                                      : input.length > 20
                                          ? 'Please enter only 20 characters'
                                          : null,
                                  suffixIcon: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      controller.hidepassword.value =
                                          !controller.hidepassword.value;
                                    },
                                    child: Icon(
                                      controller.hidepassword.value
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: themecontroller.textcolor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                )),
                          ],
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
                              internetController.internetCheckerFun();
                              print(
                                  '${controller.emailController.value.text.toString()}');

                              if (_formkey.currentState!.validate()) {
                                if (internetController
                                        .isInternetConnected.value ==
                                    true) {
                                  controller.loginWithEmail(
                                      context,
                                      controller.emailController.value.text,
                                      controller.passwordController.value.text);
                                } else {
                                  FlutterToastDisplay.getInstance
                                      .showToast("Please check your internet");
                                }
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

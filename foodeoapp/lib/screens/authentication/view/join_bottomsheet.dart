import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/screens/authentication/view_model/auth_view_model.dart';
import 'package:get/get.dart';
import '../../../components/round_button.dart';
import 'login_screen.dart';
import 'login_with_email.dart';
import 'phone_auth_screen.dart';

class JoinBottomSheet extends StatelessWidget {
  JoinBottomSheet({super.key});
  final controller = Get.put(AuthViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: themecontroller.bgcolor,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.sp),
                topRight: Radius.circular(40.sp)),
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/food3.jpg',
              ),
              repeat: ImageRepeat.repeat,
              opacity: 0.6,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.sp),
                topRight: Radius.circular(40.sp)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.95,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 12.sp),
                    RoundButton(
                      margin: 0,
                      backgroundColor: themecontroller.colorPrimary,
                      borderColor: themecontroller.colorwhite,
                      height: 58.sp,
                      onTap: () {
                        controller.selectedUserType.value = 'user';
                        log('object  ${controller.selectedUserType.value}');
                        Navigation.getInstance
                            .screenNavigation(context, LoginScreen());
                      },
                      title: 'Login as a User',
                      gradient: true,
                      textColor: themecontroller.colorwhite,
                    ),
                    SizedBox(height: 12.sp),
                    RoundButton(
                      margin: 0,
                      backgroundColor: themecontroller.colorPrimary,
                      borderColor: themecontroller.colorwhite,
                      height: 58.sp,
                      gradient: true,
                      onTap: () {
                        controller.selectedUserType.value = 'owner';
                        log('object  ${controller.selectedUserType.value}');
                        Navigation.getInstance
                            .screenNavigation(context, LoginScreen());
                      },
                      title: 'Login as a Restaurant',
                      textColor: themecontroller.colorwhite,
                    ),
                    SizedBox(height: 20.sp),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

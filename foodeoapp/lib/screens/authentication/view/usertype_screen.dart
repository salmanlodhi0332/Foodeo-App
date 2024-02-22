// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/screens/authentication/view/login_screen.dart';
import 'package:foodeoapp/screens/videos/view/videoreels_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/round_button.dart';
import '../../../helper/data_storage.dart';
import '../../profile/view/profile_screen.dart';
import '../view_model/auth_view_model.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    isloggedcheck();
  }

  String? token;
  isloggedcheck() async {
    log('UserToken');
    SharedPreferences instance = await SharedPreferences.getInstance();

    token = instance.getString("token");
    log(token.toString());
    if (token != null) {
      var _pref = DataStroge();

      await _pref.getUserData();
      if (DataStroge.userRole == 'owner') {
        print("Restaurant Token :${DataStroge.userToken}");
        Navigation.getInstance.pagePushAndReplaceNavigation(
          context,
          ProfileScreen(),
        );
      } else {
        Navigation.getInstance
            .pagePushAndReplaceNavigation(context, VideoReelsScreen());
      }
    } else {
      print('no user');
      // Navigation.getInstance
      //     .pagePushAndReplaceNavigation(context, UserTypeScreen());
    }
  }

  final controller = Get.put(AuthViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleSplash,
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: Constants.screenPadding),
            decoration: BoxDecoration(
              gradient: themecontroller.backgroundGradient,
              color: themecontroller.colorPrimary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100.sp,
                  width: 100.sp,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: themecontroller.colorwhite,
                      shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    "assets/icons/Yummy.svg",
                    color: themecontroller.colorPrimary,
                  ),
                ),
                SizedBox(height: 30.sp),
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
                SizedBox(height: 12.sp),
                RoundButton(
                  margin: 0,
                  height: 58.sp,
                  onTap: () {
                    log('object  ${controller.selectedUserType.value}');
                    Navigation.getInstance.pagePushAndReplaceNavigation(
                        context, VideoReelsScreen());
                  },
                  title: 'Login as a Guest',
                  textColor: themecontroller.colorPrimary,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

//

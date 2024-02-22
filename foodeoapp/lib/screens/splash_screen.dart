// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/screens/profile/view/profile_screen.dart';
import 'package:foodeoapp/screens/videos/view/videoreels_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication/view/usertype_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1000), () {
      isloggedcheck();
    });
  }

  String? token;
  isloggedcheck() async {
    log('messageLogin1');
    SharedPreferences instance = await SharedPreferences.getInstance();
    token = instance.getString("token");
    log(token.toString());
    if (token != null) {
      print(token.toString());
      log('messageLogin123');
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
      Navigation.getInstance
          .pagePushAndReplaceNavigation(context, UserTypeScreen());
    }
  }

  // String? token;
  // isloggedcheck() async {
  //   SharedPreferences instance = await SharedPreferences.getInstance();
  //   token = instance.getString("token");
  //   if (token != null) {
  //     var _pref = shared_preferences();
  //     await _pref.Get_userData();
  //     Page_Navigation.getInstance
  //         .Page_pushAndRemoveUntil(context, Bottom_Bar());
  //   } else {
  //     Page_Navigation.getInstance
  //         .Page_pushAndRemoveUntil(context, OnBoardingScreen());
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleSplash,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: themecontroller.backgroundGradient,
              color: themecontroller.colorPrimary,
            ),
            child: Center(
              child: Container(
                height: 100.sp,
                width: 100.sp,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: themecontroller.colorwhite, shape: BoxShape.circle),
                child: SvgPicture.asset(
                  "assets/icons/Yummy.svg",
                  color: themecontroller.colorPrimary,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

//

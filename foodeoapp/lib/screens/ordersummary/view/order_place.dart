import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/screens/videos/view/videoreels_screen.dart';
import 'package:get/get.dart';

class OrderPlace extends StatelessWidget {
  const OrderPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleMain,
        child: Scaffold(
          backgroundColor: themecontroller.backgoundcolor,
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.screenPadding, vertical: 20),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: SvgPicture.asset(
                            "assets/icons/foodeo1.svg",
                            height: 120.sp,
                            width: 120.sp,
                            // ignore: deprecated_member_use
                            // color: themecontroller.colorPrimary,
                          )),
                          const SizedBox(height: 50),
                          Text(
                            "Thank you for coming by",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: themecontroller.textcolor),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "you will now be directed to the app of your selected delivery provider to submit your orders",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: themecontroller.textcolor),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                  RoundButton(
                    margin: 0,
                    height: 50.sp,
                    gradient: true,
                    title: 'Browse more dishes',
                    onTap: () {
                      Navigation.getInstance.pagePushAndReplaceNavigation(
                          context, VideoReelsScreen());
                    },
                    // backgroundColor: themecontroller.colorPrimary,
                    textColor: themecontroller.colorwhite,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

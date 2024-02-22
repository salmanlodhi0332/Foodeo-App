import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';

class profileCount extends StatelessWidget {
  const profileCount(
      {super.key,
      required this.icon,
      required this.title,
      required this.count,
      this.iconColor,
      required this.showIcon});
  final String icon;
  final Color? iconColor;
  final String title;
  final String count;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeHelper());
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              showIcon
                  ? SvgPicture.asset(
                      icon,
                      color: iconColor,
                      width: 25,
                    )
                  : Container(),
              SizedBox(
                width: 5,
              ),
              Text(
                count,
                style: TextStyle(
                    color: themeController.textcolor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Text(
            title,
            style: TextStyle(color: themeController.textcolor, fontSize: 10.sp),
          )
        ],
      ),
    );
  }
}

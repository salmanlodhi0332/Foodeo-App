import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/constant/constants.dart';

class setting_tile extends StatelessWidget {
  final String name;
  final Color? nameColor;
  final String leadingSVG;
  final Color? LeadingColor;
  final Function()? onTap;
  final bool showtrailing;
  const setting_tile(
      {super.key,
      required this.name,
      this.nameColor,
      required this.leadingSVG,
      this.LeadingColor,
      this.onTap,
      required this.showtrailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: ListTile(
          onTap: onTap,
          leading: SvgPicture.asset(
            leadingSVG,
            color: LeadingColor ?? Colors.black,
            width: 20.sp,
            height: 20.sp,
          ),
          title: Text(
            name,
            style: TextStyle(
                color: nameColor ?? Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp),
          ),
          trailing: Visibility(
              visible: showtrailing,
              child: const Icon(Icons.arrow_forward_ios_rounded))),
    );
  }
}

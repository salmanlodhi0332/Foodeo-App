import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';

class reelsCard extends StatelessWidget {
  // final String backgroundImageUrl;
  // final String label;
  // final String location;
  // final String Description;
  // final String ViewCount;
  // // final String buttonText;
  // final VoidCallback onPressed;
  // final double width;
  // final double height;

  reelsCard(
      {
      // required this.backgroundImageUrl,
      // required this.label,
      // required this.ViewCount,
      // // required this.buttonText,
      // required this.onPressed,
      // required this.width,
      // required this.height,
      // required this.location,
      // required this.Description, required this.streamModel, required this.onTap,
      required this.url,
      required this.onTap,
      required this.yummiesCount});
  final String? url;
  final int yummiesCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeHelper());
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          // width: width,
          // height: height,
          decoration: BoxDecoration(
            color: themeController.circlecolor,
            borderRadius: BorderRadius.circular(17.0),
            image: DecorationImage(
              image: NetworkImage(url!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        //
        Positioned(
          bottom: 8.0,
          left: 8.0,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: themeController.textcolor.withOpacity(0.6),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: SvgPicture.asset(
                        "assets/icons/play.svg",
                        color: themeController.bordercolor.withOpacity(0.8),
                        height: 8.sp,
                      ),
                    ),
                    Text(
                      '${yummiesCount}', // streamModel.streamId.toString(),
                      style: TextStyle(
                        color: themeController.bordercolor.withOpacity(0.8),
                        fontSize: 8.sp,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

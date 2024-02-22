import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';

class CommentCard extends StatelessWidget {
  final String userProfileImage;
  final String userName;
  final String time;
  final String comment;

  CommentCard({
    required this.userProfileImage,
    required this.userName,
    required this.time,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeHelper());
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 10,
          left: Constants.screenPadding,
          right: Constants.screenPadding),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.sp),
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: themeController.cardcolor,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.1),
          //     offset: const Offset(0, 5),
          //     blurRadius: 10,
          //     spreadRadius: 0,
          //   ),
          // ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        radius: 22.sp,
                        backgroundImage: NetworkImage(userProfileImage),
                      ),
                    ),
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  time,
                  style: TextStyle(
                      fontSize: 9.sp, color: Colors.black.withOpacity(0.3)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 8),
              child: Row(
                children: [
                  Container(
                    // margin: EdgeInsets.only(top: 8, right: 10.sp),
                    width: 280.sp,
                    child: Text(
                      comment,
                      style: TextStyle(
                          color: themeController.textcolor, fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    // .pOnly(
    //     bottom: 10,
    //     left: Constants.screenPadding,
    //     right: Constants.screenPadding);
  }
}

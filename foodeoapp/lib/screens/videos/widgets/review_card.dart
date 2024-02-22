import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';

class ReviewCard extends StatelessWidget {
  final String userProfileImage;
  final String userName;
  final double rating;
  final String comment;

  ReviewCard({
    required this.userProfileImage,
    required this.userName,
    required this.rating,
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: themeController.bgcolor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
          // gradient: themeController.containerGradient,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Constants.screenPadding,
              horizontal: Constants.screenPadding),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Left side: User profile picture and name
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(userProfileImage),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            // Right side: Review rating stars
                            // Icon(
                            //   Icons.star,
                            //   color: Colors.yellow,
                            // ),
                            Text(
                              'hour ago',
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  color: Colors.black.withOpacity(0.3)),
                            ),
                          ],
                        ),
                        // Review comment
                      ],
                    ),
                  ),
                  Container(
                      child: RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    unratedColor: Color.fromARGB(255, 179, 185, 4),
                    itemSize: 16.sp,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 4,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 241, 246, 99),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  )),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: 280.sp,
                      child: Text(
                        comment,
                        style: TextStyle(
                            color: themeController.textcolor.withOpacity(0.5),
                            fontSize: 10.sp),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    // .pOnly(
    //     bottom: 10,
    //     left: Constants.screenPadding,
    //     right: Constants.screenPadding);
  }
}

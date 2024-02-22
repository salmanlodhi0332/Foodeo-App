import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../components/image_widget.dart';
import '../../../components/round_button.dart';
import '../../../components/spring_widget.dart';
import '../../../constant/constants.dart';
import '../../../constant/theme.dart';

class MyOrderCard extends StatelessWidget {
  const MyOrderCard({
    Key? key,
    this.pastTab = false,
    required this.restarurantName,
    required this.restarurantImage,
    this.activebutton = false,
    required this.item,
    required this.km,
    required this.price,
    this.statustitle,
    required this.height,
    this.statuscolor = false,
    this.width,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.black,
    required this.image,
    required this.title,
    this.iconColor,
    this.reOrderTap,
    this.reViewTap,
    this.margin = 20,
    this.borderColor = Colors.white,
    this.loading = false,
  }) : super(key: key);
  final String title;
  final String image;
  final String restarurantName;
  final String restarurantImage;
  final String price;
  final String item;
  final String km;
  final String? statustitle;
  final double height;
  final double? width;
  final Color backgroundColor;
  final Color textColor;
  final bool statuscolor;
  final Color? iconColor;
  final Color? borderColor;
  final VoidCallback? reOrderTap;

  final VoidCallback? reViewTap;
  final double margin;
  final bool loading;
  final bool pastTab;
  final bool activebutton;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 8.sp),
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: themecontroller.cardcolor,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ImageWidget(
                        height: 45.sp,
                        width: 45.sp,
                        imageUrl: restarurantImage,
                        boxfit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    FittedBox(
                      child: Text(
                        restarurantName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            color: themecontroller.textcolor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ]),
              SizedBox(height: 15.sp),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ImageWidget(
                      height: 60.sp,
                      width: 60.sp,
                      imageUrl: image,
                      boxfit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10.sp),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                                color: themecontroller.textcolor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.5.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${Constants.currency} ${price}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    color: themecontroller.colorPrimary,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 5.sp,
                                ),
                                child: Text('${item}x'),
                              ),
                            ],
                          ),
                        ),
                        // if (activebutton)
                        //   RoundButton(
                        //     textColor: themecontroller.colorwhite,
                        //     backgroundColor: themecontroller.colorPrimary,
                        //     height: 25.sp,
                        //     width: 100.sp,
                        //     margin: 0,
                        //     title: 'In Process',
                        //     onTap: () {},
                        //   ),
                      ],
                    ),
                  )
                ],
              ),
              // if (pastTab)
              //   Padding(
              //     padding: EdgeInsets.only(top: 12.sp),
              //     child: Row(
              //       children: [
              //         Expanded(
              //           child: SpringWidget(
              //               onTap: reViewTap!,
              //               child: Container(
              //                 padding: EdgeInsets.symmetric(vertical: 5.sp),
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(30),
              //                     border: Border.all(
              //                         color: themecontroller.colorPrimary,
              //                         width: 1.sp)),
              //                 child: Center(
              //                   child: Text(
              //                     "Add Review",
              //                     style: TextStyle(
              //                         color: themecontroller.colorPrimary,
              //                         fontSize: 10.sp,
              //                         fontWeight: FontWeight.w600),
              //                   ),
              //                 ),
              //               )),
              //         ),
              //         SizedBox(
              //           width: 12.sp,
              //         ),
              //         Expanded(
              //           child: SpringWidget(
              //               onTap: reOrderTap!,
              //               child: Container(
              //                 padding: EdgeInsets.symmetric(vertical: 5.sp),
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(30),
              //                   color: activebutton
              //                       ? themecontroller.colorwhite
              //                       : themecontroller.colorPrimary,
              //                 ),
              //                 child: Center(
              //                   child: Text(
              //                     "Re-Order",
              //                     style: TextStyle(
              //                         color: activebutton
              //                             ? themecontroller.colorPrimary
              //                             : themecontroller.colorwhite,
              //                         fontSize: 10.sp,
              //                         fontWeight: FontWeight.w600),
              //                   ),
              //                 ),
              //               )),
              //         ),
              //       ],
              //     ),
              //   )
            ],
          ));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../components/image_widget.dart';
import '../../../components/round_button.dart';
import '../../../components/spring_widget.dart';
import '../../../constant/constants.dart';
import '../../../constant/theme.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    this.receivedTab = false,
    this.activebutton = false,
    required this.item,
    required this.km,
    required this.price,
    this.statustitle,
    required this.height,
    this.viewbuttontitle,
    this.statuscolor = false,
    this.width,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.black,
    required this.image,
    required this.title,
    this.iconColor,
    this.onTap,
    this.declineTap,
    this.acceptTap,
    this.margin = 20,
    this.borderColor = Colors.white,
    this.loading = false,
    this.statusbutton = false,
    this.gradient = false,
    this.viewbutton = false,
  }) : super(key: key);
  final String title;
  final String image;
  final String price;
  final String item;
  final String km;
  final String? statustitle;
  final String? viewbuttontitle;
  final double height;
  final double? width;
  final Color backgroundColor;
  final Color textColor;
  final bool statuscolor;
  final Color? iconColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final VoidCallback? declineTap;

  final VoidCallback? acceptTap;
  final double margin;
  final bool loading;
  final bool gradient;
  final bool viewbutton;
  final bool receivedTab;
  final bool activebutton;
  final bool statusbutton;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 8.sp),
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            // color: themecontroller.colorwhite,
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
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              color: themecontroller.textcolor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        // FittedBox(
                        //   child: Text(
                        //     title,
                        //     maxLines: 1,
                        //     overflow: TextOverflow.ellipsis,
                        //     softWrap: false,
                        //     style: TextStyle(
                        //         color: themecontroller.textcolor,
                        //         fontSize: 15.sp,
                        //         fontWeight: FontWeight.w600),
                        //   ),
                        // ),
                        // FittedBox(
                        //   child: Text(
                        //     '${item} items' + "  |  " + "${km} KM",
                        //     maxLines: 1,
                        //     overflow: TextOverflow.ellipsis,
                        //     softWrap: false,
                        //     style: TextStyle(
                        //         color:
                        //             themecontroller.textcolor.withOpacity(0.2),
                        //         fontSize: 12.sp,
                        //         fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                        Row(
                          children: [
                            Text(
                              '${Constants.currency} ${price}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  color: themecontroller.colorPrimary,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 12.sp),
                            if (statusbutton)
                              GestureDetector(
                                child: AnimatedContainer(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.sp, vertical: 6.sp),
                                    decoration: BoxDecoration(
                                      color: statuscolor
                                          ? themecontroller.colorwhite
                                          : themecontroller.colorPrimary,
                                      gradient: gradient
                                          ? themecontroller.backgroundGradient
                                          : null,
                                      borderRadius: BorderRadius.circular(8.sp),
                                      border: Border.all(
                                          color: statuscolor
                                              ? themecontroller.colorPrimary
                                              : themecontroller.colorwhite,
                                          width: 1),
                                      boxShadow: [
                                        BoxShadow(
                                          color: themecontroller.bgcolor
                                              .withOpacity(0.1),
                                          spreadRadius: 1.5,
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    duration: const Duration(milliseconds: 150),
                                    child: Text(
                                      statustitle!,
                                      style: TextStyle(
                                          color: statuscolor
                                              ? themecontroller.colorPrimary
                                              : themecontroller.colorwhite,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    )),
                              )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              // SizedBox(height: 12.sp),
              if (viewbutton)
                RoundButton(
                  textColor: themecontroller.colorwhite,
                  backgroundColor: themecontroller.colorPrimary,
                  height: 30.sp,
                  margin: 0,
                  title: viewbuttontitle!,
                  onTap: onTap!,
                ),
              if (receivedTab)
                Row(
                  children: [
                    Expanded(
                      child: SpringWidget(
                          onTap: declineTap!,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5.sp),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: themecontroller.colorPrimary,
                                    width: 1.sp)),
                            child: Center(
                              child: Text(
                                "Decline",
                                style: TextStyle(
                                    color: themecontroller.colorPrimary,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 12.sp,
                    ),
                    Expanded(
                      child: SpringWidget(
                          onTap: acceptTap!,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: activebutton
                                  ? themecontroller.colorwhite
                                  : themecontroller.colorPrimary,
                            ),
                            child: Center(
                              child: Text(
                                "Accept",
                                style: TextStyle(
                                    color: activebutton
                                        ? themecontroller.colorPrimary
                                        : themecontroller.colorwhite,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )),
                    ),
                  ],
                )
            ],
          ));
    });
  }
}

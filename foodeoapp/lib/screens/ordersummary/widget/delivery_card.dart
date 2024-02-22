import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../components/spring_widget.dart';
import '../../../constant/theme.dart';

class DeliveryCard extends StatelessWidget {
  final int id;
  final String name;
  final String time;
  final String deliveryFees;
  final String serviceFees;
  final String deliveryImage;

  final VoidCallback orderTap;
  DeliveryCard(
      {super.key,
      required this.id,
      required this.name,
      required this.time,
      required this.deliveryFees,
      required this.serviceFees,
      required this.deliveryImage,
      required this.orderTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return Container(
        margin: EdgeInsets.only(bottom: 10.sp, top: 15.sp),
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: themecontroller.cardcolor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
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
                        backgroundImage: NetworkImage(deliveryImage),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 130.sp,
                          child: Text(
                            name,
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: themecontroller.textcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "Delivery Provider",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: themecontroller.textcolor2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SpringWidget(
                    onTap: orderTap,
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: themecontroller.colorPrimary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Place Order",
                          style: TextStyle(
                              color: themecontroller.colorwhite,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
              child: Divider(
                thickness: 0.5,
                color: themecontroller.textcolor2.withOpacity(0.2),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        time,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: themecontroller.textcolor,
                            fontSize: 11.sp),
                      ),
                    ),
                    Text(
                      "Est. Time",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themecontroller.textcolor.withOpacity(0.7),
                          fontSize: 11.sp),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        Constants.currency + deliveryFees,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: themecontroller.textcolor,
                            fontSize: 11.sp),
                      ),
                    ),
                    Text(
                      "Delivery Fees",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themecontroller.textcolor.withOpacity(0.7),
                          fontSize: 11.sp),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        Constants.currency + serviceFees,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: themecontroller.textcolor,
                            fontSize: 11.sp),
                      ),
                    ),
                    Text(
                      "Service Fees",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themecontroller.textcolor.withOpacity(0.7),
                          fontSize: 11.sp),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}

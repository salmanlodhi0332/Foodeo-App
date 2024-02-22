// ignore_for_file: must_be_immutable
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/flutter_toast.dart';
import 'package:foodeoapp/screens/ordersummary/model/order_delivery_model.dart';
import 'package:foodeoapp/screens/ordersummary/viewmodel/order_delivery_model_view.dart';
import 'package:get/get.dart';
import '../../../components/spring_widget.dart';
import '../../../constant/theme.dart';
import '../../../helper/internet_controller.dart';
import '../viewmodel/order_summary_model_view.dart';
import '../widget/delivery_card.dart';

class DeliveryScreen extends StatefulWidget {
  final int productId;
  DeliveryScreen({super.key, required this.productId});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final controller = Get.put(OrderDeliveryModelView());
  final internetController = Get.put(InternetController());
  final mycarcontroller = Get.put(OrderSummaryModelView());

  @override
  void initState() {
    super.initState();
    controller.getOrderDelivery(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleMain,
        child: Scaffold(
          appBar: CustomAppBar(
            leading: () {
              Navigator.pop(context);
            },
            title: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: themecontroller.circlecolor.withOpacity(0.5)),
              child: Padding(
                padding: EdgeInsets.all(15),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: SvgPicture.asset(
                        "assets/icons/food_delivery.svg",
                      )),
                  Text(
                    'Select a Delivery Provider',
                    style: TextStyle(
                        color: themecontroller.textcolor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                  )
                ]),
              ),
            ),
            margin: 0,
          ),
          backgroundColor: themecontroller.backgoundcolor,
          resizeToAvoidBottomInset: true,
          body: Padding(
              padding: const EdgeInsets.only(
                left: Constants.screenPadding,
                right: Constants.screenPadding,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 13.sp, vertical: 15.sp),
                    child: const Text(
                      'Select the delivery provider you would like to deliver your order. Upon selecting your will be diverted to their app to submit your order',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Obx(
                    () => Container(
                        // width: double.infinity,
                        height: 60,
                        margin: EdgeInsets.only(right: 50.sp, left: 50.sp),
                        decoration: BoxDecoration(
                          color: themecontroller.cardcolor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SpringWidget(
                                onTap: () {
                                  controller.current.value = false;
                                  log(controller.current.value.toString());
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.sp),
                                  decoration: BoxDecoration(
                                    color: controller.current.value == false
                                        ? themecontroller.circlecolor
                                            .withOpacity(0.8)
                                        : themecontroller.cardcolor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Fastest delivery",
                                      style: TextStyle(
                                          color:
                                              controller.current.value == false
                                                  ? themecontroller.textcolor
                                                  : themecontroller.textcolor2,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )),
                            SpringWidget(
                                onTap: () {
                                  controller.current.value = true;

                                  log(controller.current.value.toString());
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.sp),
                                  decoration: BoxDecoration(
                                    color: controller.current.value == true
                                        ? themecontroller.circlecolor
                                            .withOpacity(0.8)
                                        : themecontroller.cardcolor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Lowest cost",
                                      style: TextStyle(
                                          color:
                                              controller.current.value == true
                                                  ? themecontroller.textcolor
                                                  : themecontroller.textcolor2,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )),
                          ],
                        )
                        //  ListView.builder(
                        //     physics: const BouncingScrollPhysics(),
                        //     itemCount: catename.length,
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (ctx, index) {
                        //       return Column(
                        //         children: [
                        //           GestureDetector(
                        //             onTap: () {
                        //               controller.current.value = index;
                        //             },
                        //             child: AnimatedContainer(
                        //               duration: const Duration(milliseconds: 300),
                        //               margin: const EdgeInsets.all(5),
                        //               decoration: BoxDecoration(
                        //                 color: controller.current.value == index
                        //                     ? Theme.of(context).primaryColor
                        //                     : Theme.of(context)
                        //                         .primaryColor
                        //                         .withOpacity(0.1),
                        //                 borderRadius:
                        //                     controller.current.value == index
                        //                         ? BorderRadius.circular(12)
                        //                         : BorderRadius.circular(10),
                        //               ),
                        //               child: Text(
                        //                 catename[index],
                        //                 style: TextStyle(
                        //                     fontSize: 12,
                        //                     fontWeight: FontWeight.w600,
                        //                     color: controller.current.value ==
                        //                             index
                        //                         ? Theme.of(context).cardColor
                        //                         : Theme.of(context).hintColor),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       );
                        //     }),
                        ),
                  ),
                  Obx(() => controller.current.value == false
                      ? controller.isLoading.value
                          ? const Expanded(child: Center(child: SmallLoader()))
                          : controller.orderDeliveryList.isEmpty
                              ? const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Text('The list is empty!')],
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      itemCount:
                                          controller.orderDeliveryList.length,
                                      itemBuilder: (context, index) {
                                        OrderDeliveryModel item =
                                            controller.orderDeliveryList[index];

                                        return DeliveryCard(
                                          id: item.id!,
                                          time: item.time!,
                                          deliveryFees: item.deliveryFees!,
                                          name: item.name!,
                                          serviceFees: item.serviceFees!,
                                          deliveryImage: item.deliveryImage!,
                                          orderTap: () {
                                            internetController
                                                .internetCheckerFun();
                                            if (internetController
                                                    .isInternetConnected
                                                    .value ==
                                                true) {
                                              mycarcontroller.postOrderProceed(
                                                  context,
                                                  widget.productId,
                                                  mycarcontroller
                                                      .productQuantity
                                                      .value
                                                      .quantity!
                                                      .value,
                                                  mycarcontroller
                                                      .productQuantity
                                                      .value
                                                      .subTotal!
                                                      .value,
                                                  mycarcontroller.restaurantData
                                                      .value.restaurantId!,
                                                  mycarcontroller.noteController
                                                      .value.text,
                                                  item.id!,
                                                  item.orderUrl!);
                                            } else {
                                              FlutterToastDisplay.getInstance
                                                  .showToast(
                                                      "Please check your internet");
                                            }
                                          },
                                        );
                                      }),
                                )
                      : controller.isLoading.value
                          ? const Expanded(child: Center(child: SmallLoader()))
                          : controller.orderDeliveryList.isEmpty
                              ? const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Text('The list is empty!')],
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      itemCount:
                                          controller.orderDeliveryList.length,
                                      itemBuilder: (context, index) {
                                        OrderDeliveryModel item =
                                            controller.orderDeliveryList[index];
                                        return DeliveryCard(
                                          id: item.id!,
                                          time: item.time!,
                                          deliveryFees: item.deliveryFees!,
                                          name: item.name!,
                                          serviceFees: item.serviceFees!,
                                          deliveryImage: item.deliveryImage!,
                                          orderTap: () {
                                            internetController
                                                .internetCheckerFun();
                                            if (internetController
                                                    .isInternetConnected
                                                    .value ==
                                                true) {
                                              mycarcontroller.postOrderProceed(
                                                  context,
                                                  widget.productId,
                                                  mycarcontroller
                                                      .productQuantity
                                                      .value
                                                      .quantity!
                                                      .value,
                                                  mycarcontroller
                                                      .productQuantity
                                                      .value
                                                      .subTotal!
                                                      .value,
                                                  mycarcontroller.restaurantData
                                                      .value.restaurantId!,
                                                  mycarcontroller.noteController
                                                      .value.text,
                                                  item.id!,
                                                  item.orderUrl!);
                                            } else {
                                              FlutterToastDisplay.getInstance
                                                  .showToast(
                                                      "Please check your internet");
                                            }
                                          },
                                        );
                                      }),
                                ))

                  //  Container(
                  //     margin: EdgeInsets.only(bottom: 10.sp),
                  //     padding: EdgeInsets.all(15.sp),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(30),
                  //       color: themecontroller.colorwhite,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.2),
                  //           offset: const Offset(0, 5),
                  //           blurRadius: 10,
                  //           spreadRadius: 0,
                  //         ),
                  //       ],
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment:
                  //               MainAxisAlignment.spaceBetween,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Row(
                  //               crossAxisAlignment:
                  //                   CrossAxisAlignment.center,
                  //               children: [
                  //                 Padding(
                  //                   padding:
                  //                       const EdgeInsets.only(right: 10),
                  //                   child: CircleAvatar(
                  //                     radius: 22.sp,
                  //                     backgroundImage: NetworkImage(
                  //                         "userProfileImage"),
                  //                   ),
                  //                 ),
                  //                 Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       "userName",
                  //                       style: TextStyle(
                  //                         fontSize: 12.sp,
                  //                         color:
                  //                             themecontroller.textcolor,
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                     Text(
                  //                       "userName",
                  //                       style: TextStyle(
                  //                         fontSize: 10.sp,
                  //                         color:
                  //                             themecontroller.textcolor2,
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //             SpringWidget(
                  //                 onTap: () {},
                  //                 child: Container(
                  //                   padding: EdgeInsets.all(10.sp),
                  //                   decoration: BoxDecoration(
                  //                     color: themecontroller.colorPrimary,
                  //                     borderRadius:
                  //                         BorderRadius.circular(30),
                  //                   ),
                  //                   child: Center(
                  //                     child: Text(
                  //                       "Place Order",
                  //                       style: TextStyle(
                  //                           color: themecontroller
                  //                               .colorwhite,
                  //                           fontSize: 10.sp,
                  //                           fontWeight: FontWeight.w600),
                  //                     ),
                  //                   ),
                  //                 )),
                  //           ],
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.symmetric(vertical: 8.sp),
                  //           child: Divider(
                  //             thickness: 0.5,
                  //             color: themecontroller.textcolor2
                  //                 .withOpacity(0.2),
                  //           ),
                  //         ),
                  //         Row(
                  //           mainAxisAlignment:
                  //               MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Column(
                  //               crossAxisAlignment:
                  //                   CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   "comment",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                       color: themecontroller.textcolor,
                  //                       fontSize: 11.sp),
                  //                 ),
                  //                 Text(
                  //                   "Est. Time",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                       color: themecontroller.textcolor
                  //                           .withOpacity(0.7),
                  //                       fontSize: 11.sp),
                  //                 ),
                  //               ],
                  //             ),
                  //             Column(
                  //               crossAxisAlignment:
                  //                   CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   "comment",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                       color: themecontroller.textcolor,
                  //                       fontSize: 11.sp),
                  //                 ),
                  //                 Text(
                  //                   "Delivery Fees",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                       color: themecontroller.textcolor
                  //                           .withOpacity(0.7),
                  //                       fontSize: 11.sp),
                  //                 ),
                  //               ],
                  //             ),
                  //             Column(
                  //               crossAxisAlignment:
                  //                   CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   "comment",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                       color: themecontroller.textcolor,
                  //                       fontSize: 11.sp),
                  //                 ),
                  //                 Text(
                  //                   "Service Fees",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                       color: themecontroller.textcolor
                  //                           .withOpacity(0.7),
                  //                       fontSize: 11.sp),
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                ],
              )),
        ),
      );
    });
  }
}

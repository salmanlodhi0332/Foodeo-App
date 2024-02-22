// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/screens/ordersummary/view/delivery_screen.dart';
import 'package:foodeoapp/screens/profile/view/profile_screen.dart';
import 'package:get/get.dart';
import '../../../components/custom_textfiled.dart';
import '../../../components/image_widget.dart';
import '../../../constant/flutter_toast.dart';
import '../../../constant/theme.dart';
import '../../../helper/internet_controller.dart';
import '../../../helper/internet_screen.dart';
import '../viewmodel/order_summary_model_view.dart';

class OrderSummaryScreen extends StatefulWidget {
  final int productId;
  OrderSummaryScreen({super.key, this.productId = 0});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  final controller = Get.put(OrderSummaryModelView());
  final internetController = Get.put(InternetController());
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.getOrderSummary(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    print('object Data ${controller.productData.value.productName}');
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
                        "assets/icons/order_summary.svg",
                      )),
                  Text(
                    'Order Summary',
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
            child: Obx(
              () => controller.isLoading.value
                  ? Center(child: SmallLoader())
                  : controller.restaurantData.value.restaurantName == null
                      ? Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/empty_cart.png',
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.sp),
                                child: FittedBox(
                                  child: Text(
                                    "Start Your Culinary Journey ",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: themecontroller.textcolor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                      color: themecontroller.textcolor
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text:
                                          'Your cart is waiting for your selections. Explore our menu and start adding',
                                    ),
                                    TextSpan(
                                      text:
                                          "dishes to create your perfect meal. Let's get your order started!",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Deliver to",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: themecontroller.textcolor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12.sp,
                                    ),
                                    // Container(
                                    //   margin: EdgeInsets.only(
                                    //       bottom: 15.sp, top: 10.sp),
                                    //   padding: EdgeInsets.symmetric(
                                    //       horizontal: 5.sp, vertical: 12.sp),
                                    //   // height: 80.sp,
                                    //   decoration: BoxDecoration(
                                    //       color: themecontroller.colorwhite,
                                    //       borderRadius:
                                    //           BorderRadius.circular(15.sp)),
                                    //   child: ListTile(
                                    //     contentPadding: EdgeInsets.zero,
                                    //     leading: CircleAvatar(
                                    //       radius: 30.sp,
                                    //       backgroundColor: themecontroller.bgcolor,
                                    //       child: SvgPicture.asset(
                                    //         "assets/icons/location.svg",
                                    //       ),
                                    //     ),
                                    //     title: Text(
                                    //       "_area",
                                    //       style: TextStyle(
                                    //           color: themecontroller.textcolor,
                                    //           fontSize: 14.sp,
                                    //           fontWeight: FontWeight.w700),
                                    //     ),
                                    //     subtitle: Text(
                                    //       "_address",
                                    //       maxLines: 2,
                                    //       softWrap: false,
                                    //       overflow: TextOverflow.ellipsis,
                                    //       style: TextStyle(
                                    //         fontSize: 12.sp,
                                    //       ),
                                    //     ),
                                    //     trailing: Icon(
                                    //       Icons.arrow_forward_ios,
                                    //       color: themecontroller.colorPrimary
                                    //           .withOpacity(0.7),
                                    //     ),
                                    //   ),
                                    // ),

                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          gradient: themecontroller
                                              .containerGradient),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Obx(() => ListTile(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                leading: CircleAvatar(
                                                  radius: 25,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: ImageWidget(
                                                        imageUrl: controller
                                                            .productData
                                                            .value
                                                            .productImage
                                                            .toString(),
                                                        height: 53.sp,
                                                        width: 53.sp,
                                                      )),
                                                ),
                                                title: Text(
                                                  controller.productData.value
                                                      .productName
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: themecontroller
                                                          .textcolor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                subtitle: Text(
                                                  Constants.currency +
                                                      controller.productData
                                                          .value.productPrice
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: themecontroller
                                                          .textcolor),
                                                ),
                                                trailing: Obx(
                                                  () => Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      GestureDetector(
                                                        behavior:
                                                            HitTestBehavior
                                                                .translucent,
                                                        onTap: () {
                                                          if (controller
                                                                  .productQuantity
                                                                  .value
                                                                  .quantity!
                                                                  .value >
                                                              1) {
                                                            log('ProductQuantity=>${controller.productQuantity.value.quantity!.value}');
                                                            controller
                                                                .decrementQuantity();
                                                          }
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              themecontroller
                                                                  .colorwhite,
                                                          radius: 15,
                                                          child: Icon(
                                                            Icons.remove,
                                                            size: 15,
                                                            color:
                                                                themecontroller
                                                                    .textcolor,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                            '${controller.productQuantity.value.quantity}'),
                                                      ),
                                                      GestureDetector(
                                                        behavior:
                                                            HitTestBehavior
                                                                .translucent,
                                                        onTap: () => controller
                                                            .incrementQuantity(),
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              themecontroller
                                                                  .colorwhite,
                                                          radius: 15,
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 15,
                                                            color:
                                                                themecontroller
                                                                    .textcolor,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     Text(
                                          //       'Add ons',
                                          //       style: TextStyle(
                                          //           color:
                                          //               themecontroller.textcolor,
                                          //           fontWeight: FontWeight.w700,
                                          //           fontSize: 12.sp),
                                          //     ),
                                          //     TextButton.icon(
                                          //         onPressed: () {},
                                          //         icon: Icon(
                                          //           Icons.edit_outlined,
                                          //           color: themecontroller
                                          //               .colorPrimary,
                                          //           size: 14.sp,
                                          //         ),
                                          //         label: Text(
                                          //           'Edit',
                                          //           style: TextStyle(
                                          //               color: themecontroller
                                          //                   .colorPrimary),
                                          //         ))
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //     height: 100.sp,
                                          //     child: Obx(
                                          //       () => controller.isLoading.value
                                          //           ? const Center(
                                          //               child: SmallLoader(),
                                          //             )
                                          //           : controller.addonsList.isEmpty
                                          //               ? Center(
                                          //                   child: Text(
                                          //                     "you havn't addons yet..",
                                          //                     style: TextStyle(
                                          //                         fontSize: 11.sp,
                                          //                         fontWeight:
                                          //                             FontWeight
                                          //                                 .w500,
                                          //                         color: themecontroller
                                          //                             .textcolor
                                          //                             .withOpacity(
                                          //                                 0.5)),
                                          //                   ),
                                          //                 )
                                          //               : ListView.builder(
                                          //                   scrollDirection:
                                          //                       Axis.horizontal,
                                          //                   itemCount: controller
                                          //                       .addonsList.length,
                                          //                   itemBuilder:
                                          //                       (context, index) {
                                          //                     final addon = controller
                                          //                             .addonsList[
                                          //                         index];
                                          //                     return CircleWithChild(
                                          //                       url: addon.picture,
                                          //                       title: addon.name,
                                          //                       price: addon.price
                                          //                           .toString(),
                                          //                     );
                                          //                   }),
                                          //     ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        height: 80.sp,
                                        // padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            gradient: themecontroller
                                                .containerGradient),
                                        child: Center(
                                          child: Obx(
                                            () => ListTile(
                                              onTap: () {
                                                Navigation.getInstance
                                                    .screenNavigation(
                                                        context,
                                                        ProfileScreen(
                                                            restaurantId: controller
                                                                .restaurantData
                                                                .value
                                                                .restaurantId!));
                                              },
                                              leading: CircleAvatar(
                                                radius: 25,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: ImageWidget(
                                                      imageUrl: controller
                                                          .restaurantData
                                                          .value
                                                          .restaurantImage
                                                          .toString(),
                                                      height: 53.sp,
                                                      width: 53.sp,
                                                    )),
                                              ),
                                              title: Text(
                                                controller.restaurantData.value
                                                    .restaurantName
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: themecontroller
                                                        .textcolor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              subtitle: Text(
                                                controller.restaurantData.value
                                                    .restaurantEmail
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: themecontroller
                                                        .textcolor),
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'View dishes',
                                                    style: TextStyle(
                                                        color: themecontroller
                                                            .colorPrimary,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: themecontroller
                                                        .colorPrimary,
                                                    size: 14.sp,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                    Form(
                                      key: _formkey,
                                      child: CustomTextFieldWidget(
                                        fieldColor: themecontroller.cardcolor
                                            .withOpacity(0.5),
                                        enabled: true,
                                        label: 'Add delivery note :',
                                        controller:
                                            controller.noteController.value,
                                        hintText:
                                            "Your Delivery note here.....",
                                        inputType: TextInputType.name,
                                        focusNode: controller.noteFocusNode
                                            .value, // Pass the FocusNode here
                                        onsubmit: () {},
                                        onchange: (value) {
                                          // apihitting = true;
                                        },
                                        validator: (input) => input!.length > 50
                                            ? 'Please enter only 50'
                                            : null,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 25),
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: themecontroller.cardcolor
                                              .withOpacity(0.5),
                                          border: Border.all(
                                              color: themecontroller.cardcolor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Obx(
                                        () => Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Main item',
                                                  style: TextStyle(
                                                      color: themecontroller
                                                          .textcolor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.sp),
                                                ),
                                                Text(
                                                  Constants.currency +
                                                      controller.productQuantity
                                                          .value.mainItem
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: themecontroller
                                                          .textcolor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.sp),
                                                )
                                              ],
                                            ),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.spaceBetween,
                                            //   children: [
                                            //     Text(
                                            //       'Add ons',
                                            //       style: TextStyle(
                                            //           color:
                                            //               themecontroller.textcolor,
                                            //           fontWeight: FontWeight.w500,
                                            //           fontSize: 12.sp),
                                            //     ),
                                            //     Text(
                                            //       Constants.currency +
                                            //           controller.productQuantity.value
                                            //               .totalAddons
                                            //               .toString(),
                                            //       style: TextStyle(
                                            //           color:
                                            //               themecontroller.textcolor,
                                            //           fontWeight: FontWeight.w500,
                                            //           fontSize: 12.sp),
                                            //     )
                                            //   ],
                                            // ),
                                            Divider(
                                              color:
                                                  themecontroller.bordercolor,
                                              thickness: 1,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Subtotal',
                                                  style: TextStyle(
                                                      color: themecontroller
                                                          .textcolor,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 12.sp),
                                                ),
                                                Text(
                                                  Constants.currency +
                                                      controller.productQuantity
                                                          .value.subTotal
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: themecontroller
                                                          .textcolor,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 12.sp),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            RoundButton(
                              margin: 0,
                              height: 60.sp,
                              title: 'Proceed',
                              onTap: () {
                                internetController.internetCheckerFun();
                                if (internetController
                                        .isInternetConnected.value ==
                                    true) {
                                  if (_formkey.currentState!.validate()) {
                                    Navigation.getInstance.screenNavigation(
                                        context,
                                        DeliveryScreen(
                                          productId: widget.productId,
                                        ));
                                  }
                                } else {
                                  FlutterToastDisplay.getInstance
                                      .showToast("Please check your internet");
                                }
                              },
                              backgroundColor: themecontroller.colorPrimary,
                              textColor: themecontroller.colorwhite,
                            ),
                            SizedBox(
                              height: 12.sp,
                            ),
                          ],
                        ),
            ),
          ),
        ),
      );
    });
  }
}

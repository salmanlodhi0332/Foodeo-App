// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/screens/receivedorder/model/order_list_model.dart';
import 'package:foodeoapp/screens/receivedorder/viewmodel/received_order_viewmodel.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../components/custom_appbar.dart';
import '../../../components/small_loader.dart';
import '../../../constant/theme.dart';
import '../../../helper/internet_controller.dart';
import '../../../helper/internet_screen.dart';
import '../widget/order_card.dart';

class RestaurantOrderScreen extends StatefulWidget {
  RestaurantOrderScreen({super.key});

  @override
  State<RestaurantOrderScreen> createState() => _RestaurantOrderScreenState();
}

class _RestaurantOrderScreenState extends State<RestaurantOrderScreen> {
  final controller = Get.put(ReceivedOrderViewModel());
  ScrollController scrollController = ScrollController();

  final internetController = Get.put(InternetController());

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    controller.receivedPageLimit.value = 1;
    controller.receivedOrderList.clear();
    controller.getRestaurantOrder();
  }

  void _onRefresh() async {
    log("refresh was called....!");
    controller.receivedPageLimit.value = 1;
    controller.receivedOrderList.clear();
    await controller.getRestaurantOrder();
    _refreshController.refreshCompleted();
    controller.receivedloading.value = false;
  }

  void _onLoading() async {
    log("onLoading was called....!");
    await Future.delayed(const Duration(milliseconds: 1000), () {
      controller.receivedPageLimit.value++;
      controller.getRestaurantOrder(page: controller.receivedPageLimit.value);
    });
    _refreshController.loadComplete();
    controller.receivedloading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleMain,
        child: Obx(
          () => internetController.isInternetConnected.isFalse
              ? NoInternetScreen(
                  onTap: () {
                    internetController.internetCheckerFun();
                  },
                )
              : Scaffold(
                  backgroundColor: themecontroller.backgoundcolor,
                  appBar: CustomAppBar(
                    appbarpadding: true,
                    leading: () {
                      Navigator.pop(context);
                    },
                    title: Text(
                      "Order Received",
                      style: TextStyle(
                          color: themecontroller.textcolor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp),
                    ),
                    margin: 0,
                  ),
                  body: Obx(
                    () => SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      header: WaterDropHeader(
                        waterDropColor: themecontroller.colorPrimary,
                      ),
                      footer: CustomFooter(
                        builder: (BuildContext context, LoadStatus? mode) {
                          Widget body;
                          if (mode == LoadStatus.idle) {
                            body = Text(
                              "pull up load",
                              style:
                                  TextStyle(color: themecontroller.textcolor),
                            );
                          } else if (mode == LoadStatus.loading) {
                            body = const SmallLoader(adaptive: false);
                          } else if (mode == LoadStatus.failed) {
                            body = Text(
                              "Load Failed!Click retry!",
                              style:
                                  TextStyle(color: themecontroller.textcolor),
                            );
                          } else if (mode == LoadStatus.canLoading) {
                            body = Text(
                              "release to load more",
                              style:
                                  TextStyle(color: themecontroller.textcolor),
                            );
                          } else {
                            body = Text(
                              "No more Data",
                              style:
                                  TextStyle(color: themecontroller.textcolor),
                            );
                          }
                          return Container(
                            height: 55.0,
                            child: Center(child: body),
                          );
                        },
                      ),
                      child: NotificationListener(
                          onNotification: (notification) {
                            log('received notification log123');
                            if (notification is ScrollEndNotification) {
                              log('received notification log');
                              if (scrollController.position.extentAfter == 0) {
                                controller.receivedPageLimit.value++;
                                controller.getRestaurantOrder(
                                    page: controller.receivedPageLimit.value);
                              }
                            }
                            if (notification
                                is OverscrollIndicatorNotification) {
                              notification.disallowIndicator();
                            }
                            return true;
                          },
                          child: controller.receivedloading.value
                              ? SmallLoader()
                              : controller.receivedOrderList.isEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/order_empty.png',
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "Empty",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: themecontroller.textcolor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "You do not have an active order at this time",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: themecontroller.textcolor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    )
                                  : ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      controller: scrollController,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: Constants.screenPadding),
                                      itemCount:
                                          controller.receivedOrderList.length,
                                      itemBuilder: (context, index) {
                                        print('objectlist' +
                                            controller.receivedOrderList.length
                                                .toString());
                                        OrderListModel item =
                                            controller.receivedOrderList[index];
                                        return OrderCard(
                                          item: item.quantity,
                                          km: item.deliveryRadius.toString(),
                                          price: item.subTotal.toString(),
                                          image: item.productImage,
                                          height: 40,
                                          title: item.productName,
                                        );
                                      })),
                    ),
                  ),
                ),
        ),
      );
    });
  }
}

// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/screens/receivedorder/model/order_list_model.dart';
import 'package:foodeoapp/screens/receivedorder/viewmodel/received_order_viewmodel.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../components/small_loader.dart';
import '../../../constant/theme.dart';
import 'order_card.dart';

class ReceivedTab extends StatefulWidget {
  ReceivedTab({super.key});

  @override
  State<ReceivedTab> createState() => _ReceivedTabState();
}

class _ReceivedTabState extends State<ReceivedTab>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.put(ReceivedOrderViewModel());
  ScrollController scrollController = ScrollController();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    controller.getReceivedOrder("received");
  }

  void _onRefresh() async {
    log("refresh was called....!");
    await controller.getReceivedOrder("received");
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    log("onLoading was called....!");
    await Future.delayed(const Duration(milliseconds: 1000), () {
      controller.receivedPageLimit.value++;
      controller.getReceivedOrder("received",
          page: controller.receivedPageLimit.value);
    });
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return SmartRefresher(
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
                style: TextStyle(color: themecontroller.textcolor),
              );
            } else if (mode == LoadStatus.loading) {
              body = const SmallLoader(adaptive: false);
            } else if (mode == LoadStatus.failed) {
              body = Text(
                "Load Failed!Click retry!",
                style: TextStyle(color: themecontroller.textcolor),
              );
            } else if (mode == LoadStatus.canLoading) {
              body = Text(
                "release to load more",
                style: TextStyle(color: themecontroller.textcolor),
              );
            } else {
              body = Text(
                "No more Data",
                style: TextStyle(color: themecontroller.textcolor),
              );
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        child: Obx(
          () => controller.receivedloading.value
              ? SmallLoader()
              : controller.receivedOrderReceivedList.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                  : NotificationListener(
                      onNotification: (notification) {
                        log('received notification log123');
                        if (notification is ScrollEndNotification) {
                          log('received notification log');
                          if (scrollController.position.extentAfter == 0) {
                         
                            controller.receivedPageLimit.value++;
                            controller.getReceivedOrder("received",
                                page: controller.receivedPageLimit.value);
                          }
                        }
                        if (notification is OverscrollIndicatorNotification) {
                          notification.disallowIndicator();
                        }
                        return true;
                      },
                      child: ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.screenPadding),
                          itemCount:
                              controller.receivedOrderReceivedList.length,
                          itemBuilder: (context, index) {
                            OrderListModel item =
                                controller.receivedOrderReceivedList[index];
                            return OrderCard(
                              item: item.quantity,
                              km: item.deliveryRadius.toString(),
                              price: item.subTotal.toString(),
                              image: item.productImage,
                              height: 40,
                              receivedTab: true,
                              declineTap: () {
                                controller
                                    .patchOrderStatus(item.orderId, 'decline')
                                    .then((value) {
                                  // controller.receivedOrderReceivedList.value.removeAt(index);
                                });
                              },
                              acceptTap: () {
                                controller.patchOrderStatus(
                                    item.orderId, 'accept');
                              },
                              title: item.productName,
                            );
                          }),
                    ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}

// import 'package:flutter/material.dart';

// class CompleteTab extends StatelessWidget {
//   const CompleteTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Complete tab'),
//     );
//   }
// }

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

class CompletedTab extends StatefulWidget {
  CompletedTab({super.key});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.put(ReceivedOrderViewModel());
  ScrollController scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    controller.getReceivedOrder("completed");
  }

  void _onRefresh() async {
    log("refresh was called....!");
    await controller.getReceivedOrder("completed");
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    log("onLoading was called....!");
    await Future.delayed(const Duration(milliseconds: 1000), () {
      controller.completePageLimit.value++;
      controller.getReceivedOrder("completed",
          page: controller.completePageLimit.value);
    });
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          () => controller.completeloading.value
              ? SmallLoader()
              : controller.receivedOrderCompletedList.isEmpty
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
                        if (notification is ScrollEndNotification) {
                          log('complete notification log123');
                          if (scrollController.position.extentAfter == 0) {
                            log('complete notification log');
                            controller.completePageLimit.value++;
                            controller.getReceivedOrder("completed",
                                page: controller.completePageLimit.value);
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
                              controller.receivedOrderCompletedList.length,
                          itemBuilder: (context, index) {
                            OrderListModel item =
                                controller.receivedOrderCompletedList[index];
                            return OrderCard(
                              viewbutton: true,
                              viewbuttontitle: 'View Review',
                              item: item.quantity,
                              km: item.deliveryRadius.toString(),
                              price: item.subTotal.toString(),
                              statuscolor: false,
                              statusbutton: true,
                              statustitle: 'Completed',
                              image: item.productImage,
                              height: 40,
                              onTap: () {},
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

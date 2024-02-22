// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/screens/myorder/widget/add_review_screen.dart';
import 'package:foodeoapp/screens/receivedorder/model/order_list_model.dart';
import 'package:foodeoapp/screens/receivedorder/viewmodel/received_order_viewmodel.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../components/small_loader.dart';
import '../../../constant/theme.dart';
import '../viewmodel/my_order_view_model.dart';
import 'myorder_card.dart';

class PastOrderTab extends StatefulWidget {
  PastOrderTab({super.key});

  @override
  State<PastOrderTab> createState() => _PastOrderTabState();
}

class _PastOrderTabState extends State<PastOrderTab>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.put(MyOrderViewModel());
  ScrollController scrollController = ScrollController();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    controller.getMyOrder(dataStatus: 'pastOrders');
  }

  void _onRefresh() async {
    log("refresh was called....!");
    await controller.getMyOrder(dataStatus: 'pastOrders');
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
        header: WaterDropHeader(
          waterDropColor: themecontroller.colorPrimary,
        ),
        child: Obx(
          () => controller.pastloading.value
              ? SmallLoader()
              : controller.myOrderPastList.isEmpty
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
                          "You do not have an Past order at this time",
                          style: TextStyle(
                              fontSize: 14,
                              color: themecontroller.textcolor,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  : ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.screenPadding),
                      itemCount: controller.myOrderPastList.length,
                      itemBuilder: (context, index) {
                        OrderListModel item = controller.myOrderPastList[index];
                        return MyOrderCard(
                          restarurantName: item.restaurantName,
                          restarurantImage: item.restaurantImage,
                          item: item.quantity,
                          km: item.deliveryRadius.toString(),
                          price: item.subTotal.toString(),
                          image: item.productImage,
                          height: 40,
                          pastTab: true,
                          reOrderTap: () {},
                          reViewTap: () {
                            Get.to(AddReviewScreen(productId: item.productId));
                          },
                          title: item.productName,
                        );
                      }),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}

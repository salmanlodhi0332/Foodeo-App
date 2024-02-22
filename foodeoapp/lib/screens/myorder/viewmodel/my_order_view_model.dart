import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodeoapp/screens/myorder/api/my_order_api.dart';
import 'package:foodeoapp/screens/receivedorder/model/order_list_model.dart';
import 'package:get/get.dart';

class MyOrderViewModel extends GetxController {
  RxList<OrderListModel> myOrderActiveList = <OrderListModel>[].obs;
  RxList<OrderListModel> myOrderPastList = <OrderListModel>[].obs;
  Rx<TextEditingController> reviewcontroller = TextEditingController().obs;
  RxDouble orderRating = 0.0.obs;
  RxBool activeloading = false.obs;
  RxBool pastloading = false.obs;
  RxBool loading = false.obs;

  getMyOrder({String? dataStatus}) async {
    try {
      if (dataStatus == 'pastOrders') {
        pastloading.value = true;
      } else {
        activeloading.value = true;
      }
      log('FiltterData $dataStatus');
      final orderData = await MyOrderAPi.getMyOrder(
        dataStatus: dataStatus,
      );
      if (dataStatus == 'pastOrders') {
        log('myOrderPastList $orderData');
        myOrderPastList.value = orderData;
        log('myOrderPastList $myOrderPastList');
        log('myOrderPastListlength ${myOrderPastList.length}');
        pastloading.value = false;
      } else {
        log('myOrderActiveList $orderData');
        myOrderActiveList.value = orderData;
        log('myOrderActiveList $myOrderActiveList');
        log('myOrderActiveListlength ${myOrderActiveList.length}');
        activeloading.value = false;
      }
    } catch (e) {
      pastloading.value = false;
      activeloading.value = false;
      log('error get My Order :$e');
    }
  }

  postOrderReview(int productId, String orderReview, double orderRating) async {
    try {
      log('AddReviewAPIHintin $productId $orderRating');
      loading.value = true;

      final orderData =
          await MyOrderAPi.postReview(productId, orderReview, orderRating);
      loading.value = false;

      print('ReviewServerResponse $orderData');
    } catch (e) {
      loading.value = false;

      print("PostReviewError$e");
    }
  }
}

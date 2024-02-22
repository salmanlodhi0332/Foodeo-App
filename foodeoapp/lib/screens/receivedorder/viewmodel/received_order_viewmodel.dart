import 'dart:developer';
import 'package:foodeoapp/screens/receivedorder/model/order_list_model.dart';
import 'package:get/get.dart';
import '../api/receivedorder_api.dart';

class ReceivedOrderViewModel extends GetxController {
  RxList<OrderListModel> receivedOrderList = <OrderListModel>[].obs;
  RxList<OrderListModel> receivedOrderReceivedList = <OrderListModel>[].obs;
  RxList<OrderListModel> receivedOrderCompletedList = <OrderListModel>[].obs;
  RxList<OrderListModel> receivedOrderCancelledList = <OrderListModel>[].obs;
  RxInt receivedPageLimit = 1.obs;
  RxInt completePageLimit = 1.obs;
  RxInt cancelsPageLimit = 1.obs;
  RxBool receivedloading = false.obs;
  RxBool completeloading = false.obs;
  RxBool cancelsloading = false.obs;
  RxBool loading = false.obs;

  getRestaurantOrder({int page = 1}) async {
    try {
      log('messagePages $page');
      // if (page == 1) {
      log('message1');
      receivedloading.value = true;
      // }

      final orderData = await ReceivedOrderAPi.getRestaurantOrder(page: page);

      if ((orderData as List<OrderListModel>).isNotEmpty) {
        log('RestaurantOrderList $orderData');
        log('RestaurantOrderPageLimit $receivedPageLimit');
        receivedOrderList.value.addAll(orderData);
        log('RestaurantOrderList $receivedOrderList');
        log('RestaurantOrderLenght ${receivedOrderList.length}');
      } else {
        receivedPageLimit.value--;
      }
      // if (orderData == []) {
      //   receivedPageLimit.value--;
      // }
      // if (receivedPageLimit.value == 1) {
      // receivedloading.value = false;
      // }
      receivedloading.value = false;
    } catch (e) {
      receivedloading.value = false;
      log('error get Received Order :$e');
    }
  }

  getReceivedOrder(
    String dataStatus, {
    int page = 1,
  }) async {
    try {
      log('messageStatus $dataStatus');
      log('messagePages $page');
      // if (page == 1) {
      //   isloading.value = true;
      // }

      if (page == 1 && "received" == dataStatus) {
        log('message1');
        receivedloading.value = true;
        // myOrderReceivedList.clear();
      } else if (page == 1 && "completed" == dataStatus) {
        log('message2');
        completeloading.value = true;
        // myOrderCompletedList.clear();
      } else if (page == 1 && "cancelled" == dataStatus) {
        log('message3');
        cancelsloading.value = true;
        // myOrderCancelledList.clear();
      }

      final orderData = await ReceivedOrderAPi.getReceivedOrder(
        dataStatus,
        page: page,
      );
      if ("received" == dataStatus) {
        if (orderData == []) {
          receivedPageLimit.value--;
        }
        log('myOrderreceivedList $orderData');
        log('receivedPageLimit $receivedPageLimit');
        receivedOrderReceivedList.value.addAll(orderData);
        log('myOrderreceivedList $receivedOrderReceivedList');
        log('myOrderreceivedListLenght ${receivedOrderReceivedList.length}');
        receivedloading.value = false;
      } else if ("completed" == dataStatus) {
        if (orderData == []) {
          completePageLimit.value--;
        }
        log('myOrderCompletedList $orderData');
        receivedOrderCompletedList.value.addAll(orderData);
        log('myOrderCompletedList $receivedOrderCompletedList');
        log('myOrderCompletedListlenght ${receivedOrderCompletedList.length}');
        completeloading.value = false;
      } else if ("cancelled" == dataStatus) {
        if (orderData == []) {
          cancelsPageLimit.value--;
        }
        log('myOrdercancelledList $orderData');
        receivedOrderCancelledList.value.addAll(orderData);
        log('myOrdercancelledList $receivedOrderCancelledList');
        log('myOrdercancelledListlength ${receivedOrderCancelledList.length}');
        cancelsloading.value = false;
      } else {
        log('No Data Found message');
        // completeloading.value = false;
        // completeloading.value = false;
        // cancelsloading.value = false;
      }
    } catch (e) {
      receivedloading.value = false;
      completeloading.value = false;
      cancelsloading.value = false;
      log('error get Received Order :$e');
    }
  }

  patchOrderStatus(int orderId, String orderAction) async {
    try {
      loading.value = true;
      log('messageorderId $orderId');
      log('messageorderAction $orderAction');

      final orderData =
          await ReceivedOrderAPi.patchOrderStatus(orderId, orderAction);
      loading.value = false;

      print('ServerResponse $orderData');
    } catch (e) {
      loading.value = false;

      print("OrderActionError$e");
    }
  }
}

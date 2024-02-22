import 'dart:developer';

import 'package:foodeoapp/screens/ordersummary/model/order_delivery_model.dart';
import 'package:get/get.dart';

import '../api/order_delivery_api.dart';

class OrderDeliveryModelView extends GetxController {
  RxBool isLoading = true.obs;
  RxBool current = false.obs;
  // RxInt current = 0.obs;

  RxList<OrderDeliveryModel> orderDeliveryList = <OrderDeliveryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  getOrderDelivery(int productId) async {
    try {
      isLoading.value = true;
      var serverResponse = await OrderDeliveryAPi.getOrderDelivery(productId);
      log("ServerResponse ${serverResponse.toString()}");
      isLoading.value = false;

      // log('productQuantity=> ${serverResponse['productQuatity']}');
      // log('restaurantData=> ${serverResponse['restaurant']}');

      // log('productData=> ${serverResponse['product']}');

      orderDeliveryList.value = serverResponse;
    } catch (e) {
      isLoading.value = false;
      log('OrderDeliveryError: $e');
    }
  }
}

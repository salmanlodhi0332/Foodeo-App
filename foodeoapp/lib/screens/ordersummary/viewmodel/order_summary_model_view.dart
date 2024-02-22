import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/navigation.dart';
import '../../brower/view/brower_screen.dart';
import '../api/order_summary_api.dart';
import '../model/order_summary_model.dart';

class OrderSummaryModelView extends GetxController {
  RxBool isLoading = false.obs;

  RxBool isproccedLoading = false.obs;

  var productQuantity = ProductQuantityModel().obs;
  var productData = Product().obs;
  var restaurantData = Restaurant().obs;
  // RxList<AddonModel> addonsList = <AddonModel>[].obs;
  final noteController = TextEditingController().obs;

  Rx<FocusNode> noteFocusNode = FocusNode().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    noteController.value.dispose();
    noteFocusNode.value.dispose();
    super.onClose();
  }

  getOrderSummary(int productId) async {
    try {
      log('messageFunctionHitt');
      isLoading.value = true;
      var serverResponse = await OrderSummaryAPi.getOrderSummary(productId);
      log("ServerResponse ${serverResponse.toString()}");
      isLoading.value = false;
      // var allergenList = (serverResponse['addons'] as List<dynamic>)
      //     .map<AddonModel>((data) => AddonModel.fromJson(data))
      //     .toList();
      // addonsList.value = allergenList;

      // log('AddonsList=> ${addonsList.toString()}');
      log('productQuantity=> ${serverResponse['productQuatity']}');
      log('restaurantData=> ${serverResponse['restaurant']}');

      log('productData=> ${serverResponse['product']}');

      productQuantity.value =
          ProductQuantityModel.fromJson(serverResponse['productQuatity']);

      log('ApiproductQuantity=> ${productQuantity.toString()}');

      restaurantData.value = Restaurant.fromJson(serverResponse['restaurant']);

      log('ApirestaurantData=> ${restaurantData.toString()}');
      productData.value = Product.fromJson(serverResponse['product']);

      log('ApirestaurantData=> ${productData.toString()}');
    } catch (e) {
      isLoading.value = false;
      log('OrderSummaryError: $e');
    }
  }

  // postOrderQuantity(int productId, int action) async {
  //   try {
  //     isquantityLoading.value = true;
  //     var serverResponse =
  //         await OrderSummaryAPi.postOrderQuantity(productId, action);

  //     log("ServerResponse ${serverResponse.toString()}");
  //     log('message');

  //     log('productData=> ${serverResponse['productQuantity']}');
  //     log('SUbData=> ${serverResponse['productQuantity']['sub_total']}');
  //     // Check if 'productQuantity' key exists in the response
  //     if (serverResponse.containsKey('productQuantity')) {
  //       log('object1 ${productQuantity.value}');
  //       productQuantity.value = ProductQuantityModel();
  //       log('object2 ${productQuantity.value.mainItem}${productQuantity.value.subTotal}');
  //       final productQuantityData = serverResponse['productQuantity'];
  //       productQuantity.value = ProductQuantityModel(
  //         subTotal: productQuantityData['sub_total'],
  //         mainItem: productQuantityData['main_item'],
  //         quantity: productQuantityData['productQuantity'],
  //         // totalAddons: productQuantityData['total_addons'].toDouble() ?? 0.0,
  //       );
  //       isquantityLoading.value = false;
  //     } else {
  //       // Handle the case where 'productQuantity' is not present in the response
  //       log('productQuantity key not found in the response.');
  //     }
  //     // upProductQuantity.value = ProductQuantityModel(
  //     //   subTotal: serverResponse['productQuatity']['sub_total'],
  //     //   mainItem: serverResponse['productQuatity']['main_item'],
  //     //   totalAddons: serverResponse['productQuatity']['total_addons'],
  //     //   quantity: serverResponse['productQuatity']['productQuantity'],
  //     // );
  //     // log('ApiproductQuantity=> ${upProductQuantity.toString()}');
  //   } catch (e) {
  //     isquantityLoading.value = false;
  //     log('OrderQuantityError: $e');
  //   }
  // }

  postOrderProceed(
    BuildContext context,
    int productId,
    // List<int> addons,
    int quantity,
    double subTotal,
    int restaurantId,
    String note,
    int deliveryProviderId,
    String orderUrl,
  ) async {
    try {
      isproccedLoading.value = true;
      var serverResponse = await OrderSummaryAPi.postOrderProceed(productId,
          quantity, subTotal, restaurantId, note, deliveryProviderId);
      isproccedLoading.value = false;
      noteController.value.clear();
      if (serverResponse != null) {
        productQuantity.value.subTotal!.value = 0.0;
        productQuantity.value.quantity!.value = 0;
        // ignore: use_build_context_synchronously
        Navigation.getInstance.screenNavigation(
            context,
            BrowserScreen(
              url: orderUrl,
            ));
      }

      log("ServerResponse ${serverResponse.toString()}");
    } catch (e) {
      isproccedLoading.value = false;
      log('OrderApiProceedError: $e');
    }
  }

  void incrementQuantity() {
    productQuantity.value.quantity!.value++;

    productQuantity.value.subTotal!.value =
        productQuantity.value.quantity!.value * productQuantity.value.mainItem!;

    log('Productsubtootal=>${productQuantity.value.subTotal!.value}');
  }

  void decrementQuantity() {
    productQuantity.value.quantity!.value--;

    productQuantity.value.subTotal!.value =
        productQuantity.value.quantity!.value * productQuantity.value.mainItem!;

    log('Productsubtootal=>${productQuantity.value.subTotal!.value}');
  }
  // void increment() {
  //   // postOrderQuantity(2, 1);
  // }

  // void decrement() {
  //   // if (productQuantity.value.quantity! > 1) {
  //   //   postOrderQuantity(2, 0);
  //   // }
  // }
}

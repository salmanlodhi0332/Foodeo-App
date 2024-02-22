import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/services/app_service.dart';
import 'package:get/get.dart';
import '../../../constant/flutter_toast.dart';
import '../../../constant/theme.dart';
import '../../brower/view/brower_screen.dart';

class OrderSummaryAPi extends AppService {
  static getOrderSummary(int productId) async {
    try {
      final response = await AppService.getInstance.dio
          .get(Constants.getOrderSummary, queryParameters: {
        "productId": productId,
      });

      log("statusCode =>${response.statusCode}");
      log('get Order Summary API done 👌✅');
      log('Data ${response.data.toString()}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map) {
          return responseData['data'];
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("Summary Error ==>${e}");
    }
  }

  static postOrderQuantity(int productId, int action) async {
    try {
      final response = await AppService.getInstance.dio.post(
          Constants.postOrderQuantity,
          queryParameters: {"productId": productId, 'action': action});
      log("statusCode =>${response.statusCode}");
      log('getOrderQuantity API done 👌✅');
      log('DataOrderQuantity  ${response.data.toString()}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map) {
          return responseData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("Summary Error ==>${e}");
    }
  }

  static postOrderProceed(
    int productId,
    // List<int> addons,
    int quantity,
    double subTotal,
    int restaurantId,
    String note,
    int deliveryProviderId,
  ) async {
    try {
      // print(object)
      final response = await AppService.getInstance.dio
          .post(Constants.postOrderProceed, data: {
        "productId": productId,
        "delivery_note": note,
        "quantity": quantity,
        "sub_total": subTotal,
        "restaurant_id": restaurantId,
        'delivery_provider_id': deliveryProviderId
      });

      log("statusCode =>${response.statusCode}");
      log('getOrderProceed API done 👌✅');
      log('DataOrderProceed  ${response.data.toString()}');
      if (response.statusCode == 200) {
        print(response.data['order_url']);
        var orderUrl = response.data['order_url'];
        // final Uri url = Uri.parse(orderUrl);

        // print(url);
        // Get.to(BrowserScreen(
        //   url: url.toString(),
        // ));
        return response.data;
      } else {
        FlutterToastDisplay.getInstance.showToast("Some Problem in Order");
      }
    } catch (e) {
      log("OrderproceedError ==>${e}");
    }
  }
}

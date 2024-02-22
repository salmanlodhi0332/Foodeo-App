import 'dart:developer';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/screens/ordersummary/model/order_delivery_model.dart';
import 'package:foodeoapp/services/app_service.dart';

class OrderDeliveryAPi extends AppService {
  static getOrderDelivery(int productId) async {
    try {
      final response = await AppService.getInstance.dio
          .get(Constants.getOrderDelivery, queryParameters: {
        "productId": productId,
      });

      log("statusCode =>${response.statusCode}");
      log('get Order Delivery API done 👌✅');
      log('Data ${response.data.toString()}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map) {
          List<OrderDeliveryModel> orderData =
              (responseData['delivery_providers'] as List)
                  .map((data) => OrderDeliveryModel.fromJson(data))
                  .toList();
          return orderData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("DeliveryOrder Error ==>${e}");
    }
  }
}

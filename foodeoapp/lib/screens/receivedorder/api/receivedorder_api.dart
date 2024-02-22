import 'dart:developer';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/services/app_service.dart';

import '../model/order_list_model.dart';

class ReceivedOrderAPi extends AppService {
  static getRestaurantOrder({
    int page = 1,
  }) async {
    try {
      final response = await AppService.getInstance.dio.get(
          Constants.getReceivedOrder,
          queryParameters: {'page': page, 'data': 'received'});
      log("statusCode =>${response.statusCode}");
      log('get Received Order API done 👌✅');
      log('Data ${response.data.toString()}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List) {
          List<OrderListModel> orderData = (response.data as List)
              .map((data) => OrderListModel.fromJson(data))
              .toList();
          return orderData;
        } else if (responseData is Map) {
          List<OrderListModel> orderData = (responseData['received'] as List)
              .map((data) => OrderListModel.fromJson(data))
              .toList();
          return orderData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("RestaurantOrderError ==>${e}");
    }
  }

  static getReceivedOrder(
    String dataStatus, {
    int page = 1,
  }) async {
    try {
      final response = await AppService.getInstance.dio
          .get(Constants.getReceivedOrder, queryParameters: {
        "restaurantId": 2,
        'page': page,
        'data': dataStatus
      });
      log("statusCode =>${response.statusCode}");
      log('get Received Order API done 👌✅');
      // log('Data ${response.data.toString()}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List) {
          List<OrderListModel> orderData = (response.data as List)
              .map((data) => OrderListModel.fromJson(data))
              .toList();
          return orderData;
        } else if (responseData is Map) {
          log("received Data ${responseData['received']}");
          log("completed Data  ${responseData['completed']}");
          log("cancelled Data  ${responseData['cancelled']}");
          List<OrderListModel> orderData = (responseData[dataStatus] as List)
              .map((data) => OrderListModel.fromJson(data))
              .toList();
          return orderData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("ReceivedOrderError ==>${e}");
    }
  }

  static patchOrderStatus(
    int orderId,
    String orderAction,
  ) async {
    try {
      final response = await AppService.getInstance.dio
          .patch(Constants.patchOrdersAction, queryParameters: {
        "orderId": 2,
        'action': orderAction,
      });
      log("statusCode =>${response.statusCode}");
      log('Patch Order Action API done 👌✅');
      log('Data ${response.data.toString()}');

      if (response.statusCode == 200) {
        final responseData = response.data;

        log("completed Data  ${responseData}");

        return responseData;
      }
    } catch (e) {
      log("ActionOrderError ==>${e}");
    }
  }
}

import 'dart:developer';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/services/app_service.dart';
import '../../receivedorder/model/order_list_model.dart';

class MyOrderAPi extends AppService {
  static getMyOrder({String? dataStatus}) async {
    try {
      final response = await AppService.getInstance.dio
          .get(Constants.getMyOrder, queryParameters: {'filter': dataStatus});
      log("statusCode =>${response.statusCode}");
      log('get My Order API done 👌✅');
      // log('Data ${response.data.toString()}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List) {
          List<OrderListModel> orderData = (response.data as List)
              .map((data) => OrderListModel.fromJson(data))
              .toList();
          return orderData;
        } else if (responseData is Map) {
          log("received Data ${responseData['orders']}");
          List<OrderListModel> orderData = (responseData['orders'] as List)
              .map((data) => OrderListModel.fromJson(data))
              .toList();
          return orderData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("MyOrderError ==>$e");
    }
  }

  static postReview(
      int productId, String orderReview, double orderRating) async {
    try {
      final response = await AppService.getInstance.dio.post(
          Constants.postReview,
          queryParameters: {'productId': productId},
          data: {'review': orderReview, 'ratings': orderRating});
      log("statusCode =>${response.statusCode}");
      log('post Review API done 👌✅');
      log('Data ${response.data.toString()}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData;
      }
    } catch (e) {
      log("PostReviewError ==>$e");
    }
  }
}

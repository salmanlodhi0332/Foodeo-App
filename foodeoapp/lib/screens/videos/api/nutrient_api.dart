import 'dart:developer';

import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/screens/videos/model/nutrients_model.dart';
import 'package:foodeoapp/services/app_service.dart';

class NutrientsAPi extends AppService {
  static getPrdouctNutrients(int productId) async {
    try {
      final response = await AppService.getInstance.dio
          .get(Constants.getPrdouctNutrients, queryParameters: {
        "productId": productId,
      });
      log("statusCode =>${response.statusCode}");
      log('get Nutrients API done 👌✅');
      log('Data ${response.data.toString()}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List) {
          List<NutrientsModel> CouponData = (response.data as List)
              .map((data) => NutrientsModel.fromjson(data))
              .toList();
          return CouponData;
        } else if (responseData is Map) {
          log(responseData['data'].toString());
          // List<NutrientsModel> nutrientData = (responseData['data'] as List)
          //     .map((data) => NutrientsModel.fromjson(data))
          //     .toList();
          return responseData['data'];
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("Nutrients Error ==>${e}");
    }
  }
}

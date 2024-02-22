import 'dart:developer';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/data/model/review_model.dart';
import 'package:foodeoapp/services/app_service.dart';

class ReviewsAPi extends AppService {
  static getPrdouctReviews(int productId) async {
    try {
      final response = await AppService.getInstance.dio
          .get(Constants.getPrdouctReview, queryParameters: {
        "productId": 1,
      });
      log("statusCode =>${response.statusCode}");
      log('get Prdouct Reviews API done 👌✅');
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<reviewModel> ReviewsData = (responseData['reviews'] as List)
              .map((data) => reviewModel.fromJson(data))
              .toList();
          return ReviewsData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("Nutrients Error ==>${e}");
    }
  }
}

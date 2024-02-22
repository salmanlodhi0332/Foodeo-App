import 'dart:developer';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/data/model/comment_model.dart';
import 'package:foodeoapp/services/app_service.dart';

class CommentAPi extends AppService {
  static postPrdouctComment(int productId, String comments) async {
    try {
      final response = await AppService.getInstance.dio
          .post(Constants.productComment, queryParameters: {
        "productId": productId,
      }, data: {
        'comment': comments
      });
      log("statusCode =>${response.statusCode}");
      log('Post Prdouct Comment API done 👌✅${response.data}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        log("Comments Data  ${responseData['comments']}");

        return responseData['comments'];
      }
    } catch (e) {
      log("Comment Error ==>${e}");
    }
  }

  static getPrdouctComment(int productId) async {
    try {
      final response = await AppService.getInstance.dio.get(
        Constants.productComment,
        queryParameters: {
          "productId": productId,
        },
      );
      log("statusCode =>${response.statusCode}");
      log('get Prdouct Comment API done 👌✅${response.data}');
      print(response.data['comments']);
      // log(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<CommentModel> commentData = (responseData['comments'] as List)
              .map((data) => CommentModel.fromJson(data))
              .toList();
          return commentData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("Comment Error ==>${e}");
    }
  }
}

import 'dart:developer';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/screens/explorepage/model/explore_model.dart';
import 'package:foodeoapp/screens/videos/model/tags_model.dart';
import 'package:foodeoapp/screens/videos/model/video_model.dart';
import '../../../services/app_service.dart';

class ExploreAPI extends AppService {
  // ExploreAPI() {}

  static Future getExploreData() async {
    try {
      final response =
          await AppService.getInstance.dio.get(Constants.exploreProduct);
      log("statusCode =>${response.statusCode}");
      log('get Explore Data API done 👌✅');
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<ExploreModel> PopularData = (responseData['products'] as List)
              .map((data) => ExploreModel.fromJson(data))
              .toList();

          List<ExploreModel> RecommendedData =
              (responseData['recommended'] as List)
                  .map((data) => ExploreModel.fromJson(data))
                  .toList();

          List<tags_model> TagsData = (responseData['allTags'] as List)
              .map((data) => tags_model.fromjson(data))
              .toList();

          print('PopularData: $PopularData');
          print('RecommendedData: $RecommendedData');
          print('tags: $TagsData');

          return {
            'PopularData': PopularData,
            'RecommendedData': RecommendedData,
            'tags': TagsData
          };
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("getreels Error ==>${e}");
    }
  }

  static Future getPopulerProductData() async {
    try {
      final response =
          await AppService.getInstance.dio.get(Constants.PopularProduct);
      log("statusCode =>${response.statusCode}");
      log('get Populer Product Data API done 👌✅');
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<ExploreModel> PopularData = (responseData['products'] as List)
              .map((data) => ExploreModel.fromJson(data))
              .toList();

          print('PopularData: $PopularData');

          return PopularData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("getreels Error ==>${e}");
    }
  }

  static Future getRecommendedProductData() async {
    try {
      final response =
          await AppService.getInstance.dio.get(Constants.RecommendedProduct);
      log("statusCode =>${response.statusCode}");
      log('get Recommeded Product Data API done 👌✅');
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<ExploreModel> PopularData = (responseData['Recommeded'] as List)
              .map((data) => ExploreModel.fromJson(data))
              .toList();

          print('PopularData: $PopularData');

          return PopularData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("getreels Error ==>${e}");
    }
  }

  static Future getProductDataByTags(String tag) async {
    try {
      final response = await AppService.getInstance.dio
          .get(Constants.exploreProduct, queryParameters: {
        "tag": tag,
      });
      log("statusCode =>${response.statusCode}");
      log('get Product Data By Tags API done 👌✅');
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<ExploreModel> PopularData = (responseData['products'] as List)
              .map((data) => ExploreModel.fromJson(data))
              .toList();

          print('PopularData: $PopularData');

          return PopularData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("getreels Error ==>${e}");
    }
  }

  static Future getSearchProduct(String search) async {
    try {
      final response = await AppService.getInstance.dio
          .get(Constants.exploreProduct, queryParameters: {
        "search": search,
      });
      log("statusCode =>${response.statusCode}");
      log('get Product Data By Tags API done 👌✅');
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<ExploreModel> PopularData = (responseData['products'] as List)
              .map((data) => ExploreModel.fromJson(data))
              .toList();

          print('PopularData: $PopularData');

          return PopularData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("getreels Error ==>${e}");
    }
  }



}

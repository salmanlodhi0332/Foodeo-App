import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/screens/addproduct/model/allergens_model.dart';
import 'package:foodeoapp/screens/addproduct/model/product_detail_model.dart';
import 'package:foodeoapp/screens/videos/model/add_video_model.dart';
import 'package:foodeoapp/screens/videos/model/serviceprovider_model.dart';
import 'package:foodeoapp/screens/videos/model/tags_model.dart';
import 'package:foodeoapp/screens/videos/model/video_model.dart';

import '../../../services/app_service.dart';

class VideoReelsAPI extends AppService {
  // VideoReelsAPI() {}

  static Future getreels() async {
    try {
      final response = await AppService.getInstance.dio.get(Constants.getReels);
      log("statusCode =>${response.statusCode}");
      log("ReelData =>${response.data}");
      log('get get reels API done 👌✅');
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<VideoModel> ReelsData = (responseData['videos'] as List)
              .map((data) => VideoModel.fromJson(data))
              .toList();
          return ReelsData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("getreels Error ==>${e}");
    }
  }

  static addOrRemoveyummy(int toggle, int videoId) async {
    try {
      final response;
      response = await AppService.getInstance.dio
          .post(Constants.toggleyummy, queryParameters: {
        'videoId': videoId,
        'toggle': toggle,
      });

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
        print('add yummy Successfully');
      } else {
        print('Something went wrong...');
      }
    } on DioException catch (e) {
      print("💥 Error: ${e.response?.data['message']}");
    }
  }

  static Future getreelsbyTags(String tag) async {
    try {
      final response = await AppService.getInstance.dio
          .get(Constants.getReels, queryParameters: {
        "filter": tag,
      });
      log("statusCode =>${response.statusCode}");
      log('get reels Data By Tags API done 👌✅');
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<VideoModel> ReelsData = (responseData['videos'] as List)
              .map((data) => VideoModel.fromJson(data))
              .toList();
          return ReelsData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("getreels Error ==>${e}");
    }
  }

  static Future getAllTags() async {
    try {
      final response = await AppService.getInstance.dio.get(Constants.gettags);
      log("statusCode =>${response.statusCode}");
      log('get all tags API done 👌✅');
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<tags_model> tagsData = (responseData['data'] as List)
              .map((data) => tags_model.fromjson(data))
              .toList();
          return tagsData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("getreels Error ==>${e}");
    }
  }

  static Future getServiceProvider() async {
    try {
      final response =
          await AppService.getInstance.dio.get(Constants.getDeliveryProviders);
      log("statusCode =>${response.statusCode}");
      log('get Service Provider API done 👌✅');
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map) {
          List<ServiceProviderModel> ServiceProviderData =
              (responseData['delivery_providers'] as List)
                  .map((data) => ServiceProviderModel.fromJson(data))
                  .toList();
          return ServiceProviderData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("getreels Error ==>${e}");
    }
  }

  static getAllergens() async {
    try {
      final response = await AppService.getInstance.dio.get(
        Constants.getAllergens,
      );

      log("statusCode =>${response.statusCode}");
      log('get Allergens API done 👌✅');
      log('Data ${response.data.toString()}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (response.statusCode == 200) {
          final responseData = response.data;

          if (responseData is Map) {
            List<AllergensModel> ReelsData = (responseData['allergens'] as List)
                .map((data) => AllergensModel.fromjson(data))
                .toList();
            return ReelsData;
          }
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("get Allergens Error ==>${e}");
    }
  }

  static getproductData(int productId) async {
    try {
      final response = await AppService.getInstance.dio.get(
          Constants.restaurantProductsByVideo,
          queryParameters: {"productId": productId});
      log("statusCode =>${response.statusCode}");
      log('get product Data API done 👌✅');
      // print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<ProductModel> productData = (responseData['product'] as List)
              .map((data) => ProductModel.fromJson(data))
              .toList();

          print('productData: $productData');

          return productData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("getrestaurantData Error ==>${e}");
    }
  }

  static uploadReel(AddVideoModel videoData) async {
    try {
      final response;
      final formData = FormData();

      // Add other fields as usual
      formData.fields.add(MapEntry('name', videoData.title));
      formData.fields.add(MapEntry('description', videoData.description));
      formData.fields.add(MapEntry('price', videoData.price));
      // formData.fields.add(MapEntry('thumbnail', videoData.thumbnail));
      // formData.fields.add(MapEntry('serverProviderId', videoData.thumbnail));

      // Convert the model lists to JSON and add as a single field
      formData.fields.add(
        MapEntry(
          'JSONservice_providers',
          jsonEncode(
            videoData.ServiceProviderList.map((Service) => Service.toJson())
                .toList(),
          ),
        ),
      );

      formData.fields.add(
        MapEntry(
          'JSONallergence',
          jsonEncode(
            videoData.allergensList
                .map((allergen) => allergen.tojson())
                .toList(),
          ),
        ),
      );
      formData.fields.add(
        MapEntry(
          'JSONtags',
          jsonEncode(
            videoData.tagsList.map((tag) => tag.tojson()).toList(),
          ),
        ),
      );

      formData.fields.add(
        MapEntry(
          'JSONnutritions',
          jsonEncode(
            videoData.nutrientList
                .map((nutrient) => nutrient.tojson())
                .toList(),
          ),
        ),
      );

      // Add the file using MultipartFile.fromFile
      formData.files.add(MapEntry(
        'files',
        await MultipartFile.fromFile(videoData.content),
      ));

      formData.files.add(MapEntry(
        'thumbnail',
        await MultipartFile.fromFile(videoData.thumbnail),
      ));

      response = await AppService.getInstance.dio.post(
        Constants.UploadReels,
        data: formData,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
        print('Print Successfully');
        // final responseData = response.data;
        // if (responseData is Map) {
        //   VideoModel ReelsData = VideoModel.fromJson(responseData['videos']);
        //   return ReelsData;
        // } else {
        //   return responseData;
        // }
      } else {
        print('Something went wrong...');
      }
    } on DioException catch (e) {
      print("💥 Error: ${e.response?.data['message']}");
    }
  }
}

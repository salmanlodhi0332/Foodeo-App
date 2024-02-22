import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/data/model/user_model.dart';
import 'package:foodeoapp/screens/profile/model/edit_restaurant_model.dart';
import 'package:foodeoapp/screens/profile/model/profile_model.dart';
import 'package:foodeoapp/screens/profile/model/restaurant_model.dart';
import 'package:foodeoapp/screens/videos/model/openinnghour_model.dart';
import 'package:foodeoapp/screens/videos/model/video_model.dart';
import 'package:foodeoapp/services/app_service.dart';

import '../../../constant/flutter_toast.dart';
import '../../../constant/theme.dart';

class ProfileAPi extends AppService {
  static getrestaurantEditProfileData() async {
    try {
      final response = await AppService.getInstance.dio.get(
        Constants.getrestaurantEditProfileData,
      );
      log("statusCode =>${response.statusCode}");
      log('get Restaurant Edit Profile Data API done 👌✅');

      if (response.statusCode == 200) {
        final responseData = response.data;

        EditRestaurant RestaurantData =
            EditRestaurant.fromJson(responseData['restaurant']);
        print(responseData['restaurant']['timings']);
        List<OpeningHoursModel> timingsData =
            (responseData['restaurant']['timings'] as List)
                .map((data) => OpeningHoursModel.fromJson(data))
                .toList();
        print('restaurant: $RestaurantData');
        print('timingsData: $timingsData');

        return {'RestaurantData': RestaurantData, 'timingsData': timingsData};
      }
    } catch (e) {
      log("ProfileData Error ==>${e}");
    }
  }

  static getrestaurantProfileData() async {
    try {
      final response = await AppService.getInstance.dio.get(
        Constants.getrestaurantProfileData,
      );
      log("statusCode =>${response.statusCode}");
      log('get Restaurant Profile Data API done 👌✅');
      // print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<RestaurantModel> RestaurantData =
              (responseData['restaurant'] as List)
                  .map((data) => RestaurantModel.fromJson(data))
                  .toList();

          List<VideoModel> VideoData = (responseData['video_contents'] as List)
              .map((data) => VideoModel.fromJson(data))
              .toList();
          print('restaurant: $RestaurantData');
          print('video_contents: $VideoData');

          return {'RestaurantData': RestaurantData, 'VideoData': VideoData};
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("ProfileData Error ==>${e}");
    }
  }

  static getrestaurantData(int restaurantId) async {
    try {
      final response = await AppService.getInstance.dio
          .get(Constants.getrestaurantProfile, queryParameters: {
        "restaurantId": restaurantId,
      });
      log("statusCode =>${response.statusCode}");
      log('get Restaurant Data API done 👌✅');
      // print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<RestaurantModel> RestaurantData =
              (responseData['restaurant'] as List)
                  .map((data) => RestaurantModel.fromJson(data))
                  .toList();

          List<VideoModel> VideoData = (responseData['video_contents'] as List)
              .map((data) => VideoModel.fromJson(data))
              .toList();
          print('restaurant: $RestaurantData');
          print('video_contents: $VideoData');

          return {'RestaurantData': RestaurantData, 'VideoData': VideoData};
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("ProfileDataById Error ==>${e}");
    }
  }

  static updateUserProfile(UserModel userData) async {
    try {
      final response;
      UserModel Updated_User;
      final formData = FormData();

      // Add other fields as usual
      if (userData.name != '') {
        formData.fields.add(MapEntry('name', userData.name.toString()));
      }
      if (userData.email != '') {
        formData.fields.add(MapEntry('email', userData.email.toString()));
      }
      if (userData.phoneNumber != '') {
        formData.fields
            .add(MapEntry('phone_number', userData.phoneNumber.toString()));
      }
      if (userData.image != '') {
        formData.files.add(MapEntry(
          'files',
          await MultipartFile.fromFile(userData.image.toString()),
        ));
      }

      response = await AppService.getInstance.dio.patch(
        Constants.updateUserDetails,
        data: formData,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
        print('Print Successfully');
        Updated_User = UserModel.fromjson(response.data['user']);
        print(Updated_User.image);
      } else {
        Updated_User = UserModel();
        print('Something went wrong...');
      }
      return Updated_User;
    } on DioException catch (e) {
      FlutterToastDisplay.getInstance
          .showToast("${e.response!.data['message']}");

      print("💥 Error: ${e.response?.data['message']}");
    }
  }

  static editRestaurantProfile(AddRestaurantModel RestaurantData) async {
    try {
      final response;
      AddRestaurantModel Updated_Restaurant;
      final formData = FormData();

      // Add other fields as usual
      if (RestaurantData.name != '') {
        formData.fields.add(MapEntry('name', RestaurantData.name.toString()));
      }
      if (RestaurantData.email != '') {
        formData.fields.add(MapEntry('email', RestaurantData.email.toString()));
      }
      if (RestaurantData.phone != '') {
        formData.fields
            .add(MapEntry('phone_number', RestaurantData.phone.toString()));
      }

      if (RestaurantData.description != '') {
        formData.fields.add(
            MapEntry('description', RestaurantData.description.toString()));
      }
      if (RestaurantData.DeliveryCharges != '') {
        formData.fields.add(MapEntry(
            'delivery_charges', RestaurantData.DeliveryCharges.toString()));
      }
      if (RestaurantData.minimumOrderAmount != '') {
        formData.fields.add(MapEntry(
            'minimum_amount', RestaurantData.minimumOrderAmount.toString()));
      }
      if (RestaurantData.image != '') {
        formData.files.add(MapEntry(
          'files',
          await MultipartFile.fromFile(RestaurantData.image.toString()),
        ));
      }
      formData.fields.add(
        MapEntry(
          'timings',
          jsonEncode(
            RestaurantData.OpeningHoursList!
                .map((hours) => hours.toJson())
                .toList(),
          ),
        ),
      );
      response = await AppService.getInstance.dio.patch(
        Constants.updateRestaurantInfo,
        data: formData,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
        print('Print Successfully');
        Updated_Restaurant =
            AddRestaurantModel.fromJson(response.data['restaurant']);
        return Updated_Restaurant;
      } else {
        Updated_Restaurant = AddRestaurantModel();
        print('Something went wrong...');
        return Updated_Restaurant;
      }
      // return Updated_Restaurant;
    } on DioException catch (e) {
      FlutterToastDisplay.getInstance
          .showToast("${e.response!.data['message']}");

      print("💥 Error: ${e.response?.data['message']}");
    }
  }
}

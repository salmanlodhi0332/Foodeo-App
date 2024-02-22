import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/screens/Addons/model/addons_model.dart';
import 'package:foodeoapp/screens/explorepage/model/explore_model.dart';
import 'package:foodeoapp/screens/videos/model/tags_model.dart';
import 'package:foodeoapp/screens/videos/model/video_model.dart';
import '../../../services/app_service.dart';

class AddonsAPI extends AppService {
  // ExploreAPI() {}

  static Future getAddonsByProductId(int productId) async {
    try {
      final response = await AppService.getInstance.dio
          .get(Constants.getaddons, queryParameters: {
        "productId": productId,
      });
      log("statusCode =>${response.statusCode}");
      log('getAddonsByProductId API done 👌✅');
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map) {
          List<AddonModel> addonsData = (responseData['addons'] as List)
              .map((data) => AddonModel.fromJson(data))
              .toList();

          print('addonsData: $addonsData');

          return addonsData;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      log("getAddonsByProductId Error ==>${e}");
    }
  }

  static Future AddAddons(int productId, int addonsId, int Action) async {
    try {
      final response = await AppService.getInstance.dio
          .post(Constants.Addaddons, queryParameters: {
        "productId": productId,
        "addonId": addonsId,
        "action": Action,
      });
      log("statusCode =>${response.statusCode}");
      log('AddAddons API done 👌✅');
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data['total'];

        return responseData;
      }
    } catch (e) {
      log("getAddonsByProductId Error ==>${e}");
    }
  }
}

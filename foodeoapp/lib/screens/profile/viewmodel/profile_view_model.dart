import 'package:flutter/material.dart';
import 'package:foodeoapp/data/model/review_model.dart';
import 'package:foodeoapp/data/model/user_model.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/screens/profile/api/profile_api.dart';
import 'package:foodeoapp/screens/profile/model/edit_restaurant_model.dart';
import 'package:foodeoapp/screens/profile/model/profile_model.dart';
import 'package:foodeoapp/screens/profile/model/restaurant_model.dart';
import 'package:foodeoapp/screens/videos/api/reviews_api.dart';
import 'package:foodeoapp/screens/videos/model/openinnghour_model.dart';
import 'package:foodeoapp/screens/videos/model/video_model.dart';
import 'package:get/get.dart';

class ProfileViewModel extends GetxController {
  RxList<RestaurantModel> RestaurantList = <RestaurantModel>[].obs;
  var EditRestaurantData = EditRestaurant().obs;
  RxList<VideoModel> VideoContentList = <VideoModel>[].obs;
  RxBool Isloading = false.obs;

  final nameController = TextEditingController();
  final DescriptionController = TextEditingController();
  // final AllergensController = TextEditingController();
  final PhoneController = TextEditingController();
  final EmailController = TextEditingController();
  final caloriesController = TextEditingController();
  final orderlengthController = TextEditingController();
  final DeliveryChargesController = TextEditingController();

  final RxString starttime = 'select start time'.obs;
  final RxString endtime = 'select end time'.obs;
  final RxString selectedDay = 'Monday'.obs;
  RxList<OpeningHoursModel> OpeningHoursList = <OpeningHoursModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // getProfileData();
  }

  getrestaurantProfileData() async {
    try {
      Isloading.value = true;
      print('getProfileData');
      final RestaurantProfileData = await ProfileAPi.getrestaurantProfileData();

      RestaurantList.value = RestaurantProfileData['RestaurantData'];
      VideoContentList.value = RestaurantProfileData['VideoData'];

      // update();
      print('RestaurantList: ${RestaurantList.length}');
      print('VideoContentList: ${VideoContentList.length}');
      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('error get Product Reviews view model:$e');
    }
  }

  getrestaurantEditProfileData() async {
    try {
      Isloading.value = true;
      print('getrestaurantEditProfileData');
      final RestaurantProfileData =
          await ProfileAPi.getrestaurantEditProfileData();
      
      EditRestaurantData.value = RestaurantProfileData['RestaurantData'];

      nameController.text = EditRestaurantData.value.name!;
      DescriptionController.text = EditRestaurantData.value.description!;
      PhoneController.text = EditRestaurantData.value.phoneNumber!;
      EmailController.text = DataStroge.userEmail.value;
      orderlengthController.text = EditRestaurantData.value.minimum_amount!;
      DeliveryChargesController.text = EditRestaurantData.value.deliveryCharges!.toString();

      OpeningHoursList.value = RestaurantProfileData['timingsData'];
      // update();
      print('RestaurantList: ${RestaurantList.length}');
      print('timingsData: ${OpeningHoursList.length}');

      Isloading.value = false;
    } catch (e) {
      // Isloading.value = false;
      print('error getrestaurantEditProfileData view model:$e');
    }
  }

  getProfileData(int restaurantId) async {
    try {
      Isloading.value = true;
      print('getProfileData');
      final RestaurantProfileData =
          await ProfileAPi.getrestaurantData(restaurantId);

      RestaurantList.value = RestaurantProfileData['RestaurantData'];
      VideoContentList.value = RestaurantProfileData['VideoData'];

      // update();
      print('RestaurantList: ${RestaurantList.length}');
      print('VideoContentList: ${VideoContentList.length}');
      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('error get Product Reviews view model:$e');
    }
  }

  editUserProfile(UserModel userData) async {
    try {
      Isloading.value = true;
      print(userData);
      final Data = await ProfileAPi.updateUserProfile(userData);
      Isloading.value = false;
      return Data;
    } catch (e) {
      Isloading.value = false;
      print('error get Product Reviews view model: $e');
    }
  }

  editRestaurantProfile(AddRestaurantModel RestaurantData) async {
    try {
      Isloading.value = true;
      print(RestaurantData);
      final Data = await ProfileAPi.editRestaurantProfile(RestaurantData);
      Isloading.value = false;
      return Data;
    } catch (e) {
      Isloading.value = false;
      print('error get Product Reviews view model: $e');
    }
  }

  @override
  void onClose() {
    OpeningHoursList.clear();
    super.onClose();
  }
}

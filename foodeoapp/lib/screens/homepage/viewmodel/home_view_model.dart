import 'package:flutter/widgets.dart';
import 'package:foodeoapp/screens/videos/api/video_api.dart';
import 'package:foodeoapp/screens/videos/model/tags_model.dart';
import 'package:foodeoapp/screens/videos/view/videoreels_screen.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final selectedIndex = 0.obs;

  RxList<Widget> currentScreen = <Widget>[
    VideoReelsScreen(),
    VideoReelsScreen(),
    VideoReelsScreen(),
    VideoReelsScreen()
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

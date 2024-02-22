import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/internet_controller.dart';
import 'package:foodeoapp/helper/internet_screen.dart';
import 'package:foodeoapp/screens/videos/model/video_model.dart';
import 'package:foodeoapp/screens/videos/view/video_player.dart';
import 'package:foodeoapp/screens/videos/widgets/video_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ViewReelScreen extends StatelessWidget {
  ViewReelScreen({super.key, required this.videoData});
  final VideoModel videoData;
  @override
  final internetController = Get.put(InternetController());

  Widget build(BuildContext context) {
    RxBool isDarkTheme = false.obs;
    return GetBuilder<ThemeHelper>(
      builder: (themecontroller) {
        return AnnotatedRegion(
          value: themecontroller.systemUiOverlayStyleForBlack,
          child: Obx(
          () => internetController.isInternetConnected.isFalse
              ? NoInternetScreen(
                  onTap: () {
                    internetController.internetCheckerFun();
                  },
                )
              : Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Videoplayer(
                    url: videoData.content,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

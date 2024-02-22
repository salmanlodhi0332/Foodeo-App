import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/screens/authentication/view/join_bottomsheet.dart';
import 'package:foodeoapp/screens/videos/view/video_player.dart';
import 'package:foodeoapp/screens/videos/viewModel/video_viewmodel.dart';
import 'package:foodeoapp/screens/videos/widgets/shared_bottom.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import '../model/video_model.dart';
import 'comment_bottom_sheet.dart';
import 'nutrients_bottom_sheet.dart';
import 'profile_order_tab.dart';

class VideoWidget extends StatelessWidget {
  VideoWidget({super.key, required this.videoData});
  final VideoModel videoData;
  final controller = Get.put(VideoViewModel());

  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeHelper());
    return Stack(
      children: [
        Videoplayer(url: videoData.content),
        if (DataStroge.userRole == 'owner')
          Positioned(
            top: 40.sp,
            left: 10.sp,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: Constants.screenPadding),
                child: CircleAvatar(
                  backgroundColor: themeController.colorwhite,
                  child: Icon(
                    Icons.arrow_back,
                    color: themeController.textcolor,
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          bottom: 140,
          right: 20,
          child: Column(
            children: [
              if (DataStroge.userRole != 'owner')
                SpringWidget(
                  onTap: () {
                    if (DataStroge.userToken == '') {
                      Get.bottomSheet(JoinBottomSheet());
                    } else {
                      videoData.liked.value = !videoData.liked.value;
                      print(videoData.liked.value);
                      if (videoData.liked.value) {
                        controller.addOrRemoveyummy(1, videoData.id);
                      } else {
                        controller.addOrRemoveyummy(0, videoData.id);
                      }
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 5,
                          sigmaY: 5), // Adjust blur intensity as needed
                      child: Obx(
                        () => CircleAvatar(
                          radius: 25.sp,
                          backgroundColor: Colors.black
                              .withOpacity(0.2), // Adjust opacity as needed
                          child: SvgPicture.asset(
                            "assets/icons/Yummy.svg",
                            height: 20.sp,
                            color: videoData.liked.value
                                ? themeController.colorPrimary
                                : themeController.colorwhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Text(
                'Yummy',
                style: TextStyle(color: Colors.white, fontSize: 10.sp),
              ),
              const SizedBox(
                height: 20,
              ),
              if (DataStroge.userRole != 'owner')
                SpringWidget(
                  onTap: () {
                    if (DataStroge.userToken == '') {
                      Get.bottomSheet(JoinBottomSheet());
                    } else {
                      Get.bottomSheet(
                          SingleChildScrollView(
                            child: CommentBottomSheet(
                              productId: videoData.productId,
                            ),
                          ),
                          isScrollControlled: true);
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: CircleAvatar(
                        radius: 25.sp,
                        backgroundColor: Colors.black
                            .withOpacity(0.2), // Adjust opacity as needed
                        child: SvgPicture.asset(
                          "assets/icons/comment.svg",
                          height: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              Text(
                'Comment',
                style: TextStyle(color: Colors.white, fontSize: 10.sp),
              ),
              const SizedBox(
                height: 20,
              ),
              if (DataStroge.userRole != 'owner')
                SpringWidget(
                  onTap: () {
                    Get.bottomSheet(shareBottomSheet());
                    // shareBottomSheet.show(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: CircleAvatar(
                        radius: 25.sp,
                        backgroundColor: Colors.black
                            .withOpacity(0.2), // Adjust opacity as needed
                        child: SvgPicture.asset(
                          "assets/icons/share.svg",
                          height: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              Text(
                'share',
                style: TextStyle(color: Colors.white, fontSize: 10.sp),
              ),
              const SizedBox(
                height: 20,
              ),
              if (DataStroge.userRole != 'owner')
                SpringWidget(
                  onTap: () {
                    Get.bottomSheet(NutrientBottomSheet(
                      productId: videoData.productId,
                    ));
                    // NutrientBottomSheet.show(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: CircleAvatar(
                        radius: 25.sp,
                        backgroundColor: Colors.black
                            .withOpacity(0.2), // Adjust opacity as needed
                        child: SvgPicture.asset(
                          "assets/icons/flash.svg",
                          height: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              Text(
                'Nutrients',
                style: TextStyle(color: Colors.white, fontSize: 10.sp),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        if (DataStroge.userRole != 'owner')
          Positioned(
              left: 15.sp,
              bottom: 30.sp,
              child: ProfileTab(
                  username: videoData.username,
                  productPrice: videoData.productPrice.toString(),
                  userId: videoData.userId,
                  restaurantId: videoData.restaurantId,
                  reelId: videoData.id,
                  productId: videoData.productId,
                  productname: videoData.title,
                  userPicture: videoData.userPicture))
      ],
    );
  }
}

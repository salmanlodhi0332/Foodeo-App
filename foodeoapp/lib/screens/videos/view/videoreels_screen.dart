import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/helper/internet_controller.dart';
import 'package:foodeoapp/helper/internet_screen.dart';
import 'package:foodeoapp/screens/authentication/view/join_bottomsheet.dart';
import 'package:foodeoapp/screens/videos/viewModel/video_viewmodel.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import '../../profile/view/profile_setting_screen.dart';
import '../widgets/video_Widget.dart';

class VideoReelsScreen extends StatelessWidget {
  VideoReelsScreen({super.key});
  final videoController = Get.put(VideoViewModel());
  final internetController = Get.put(InternetController());

  @override
  Widget build(BuildContext context) {
    RxBool isDarkTheme = false.obs;
    return GetBuilder<ThemeHelper>(
      builder: (themeController) => AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          systemNavigationBarColor: Colors.black,
          statusBarBrightness:
              isDarkTheme.value ? Brightness.dark : Brightness.light,
          statusBarIconBrightness:
              isDarkTheme.value ? Brightness.dark : Brightness.light,
          systemNavigationBarIconBrightness:
              isDarkTheme.value ? Brightness.dark : Brightness.light,
        ),
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
                      child: Obx(
                        () => Stack(
                          children: [
                            Visibility(
                              visible: videoController.Isloading.value == false,
                              replacement: const SmallLoader(),
                              child: videoController.reelsVideos.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'reels not loaded',
                                            style: TextStyle(
                                              color: themeController.colorwhite,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.sp,
                                          ),
                                          SpringWidget(
                                            onTap: () {
                                              videoController.onInit();
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  themeController.colorPrimary,
                                              child:
                                                  const Icon(Icons.restart_alt),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : PreloadPageView.builder(
                                      controller: PreloadPageController(
                                        initialPage: 0,
                                        viewportFraction: 1,
                                      ),
                                      preloadPagesCount: 1,
                                      itemCount:
                                          videoController.reelsVideos.length,
                                      onPageChanged: (index) {
                                        print(index);
                                      },
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        print(
                                            "VideosBuilder canBuild ios: $index");
                                        return Platform.isIOS
                                            ? VideoWidget(
                                                videoData: videoController
                                                    .reelsVideos[index])
                                            : VideoWidget(
                                                videoData: videoController
                                                    .reelsVideos[index]);
                                      },
                                    ),
                            ),
                            if (!videoController.settingopen.value)
                              Positioned(
                                top: Constants.screenPadding,
                                left: Constants.screenPadding,
                                child: SpringWidget(
                                  onTap: () {
                                    if (DataStroge.userToken.value == '') {
                                      Get.bottomSheet(JoinBottomSheet());
                                    } else {
                                      Navigation.getInstance.screenNavigation(
                                          context, ProfileSettingScreen());
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: CircleAvatar(
                                        radius: 20.sp,
                                        backgroundColor:
                                            Colors.black.withOpacity(0.2),
                                        child: SvgPicture.asset(
                                          "assets/icons/user-circle.svg",
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (!videoController.settingopen.value)
                              Positioned(
                                top: Constants.screenPadding,
                                left: Constants.screenPadding,
                                child: SpringWidget(
                                  onTap: () {
                                    if (DataStroge.userToken == '') {
                                      Get.bottomSheet(JoinBottomSheet());
                                    } else {
                                      // Navigation.getInstance.LeftToRight_PageNavigation(
                                      //     context,
                                      //     AddReviewScreen(
                                      //       productId: 2,
                                      //     ));

                                      Navigation.getInstance.screenNavigation(
                                          context, ProfileSettingScreen());
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: CircleAvatar(
                                        radius: 20.sp,
                                        backgroundColor:
                                            Colors.black.withOpacity(0.2),
                                        child: SvgPicture.asset(
                                          "assets/icons/user-circle.svg",
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Obx(
                              () => Positioned(
                                top: Constants.screenPadding,
                                right: Constants.screenPadding,
                                child: AnimatedContainer(
                                  width: videoController.settingopen.value
                                      ? 330.sp
                                      : 40.sp,
                                  duration: const Duration(milliseconds: 200),
                                  child: Row(
                                    children: [
                                      SpringWidget(
                                        onTap: () {
                                          // Handle tap logic
                                          videoController.settingopen.value =
                                              !videoController
                                                  .settingopen.value;
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: CircleAvatar(
                                              radius: 20.sp,
                                              backgroundColor:
                                                  Colors.black.withOpacity(0.2),
                                              child: SvgPicture.asset(
                                                "assets/icons/settings.svg",
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (videoController.settingopen.value)
                                        Obx(
                                          () => Expanded(
                                            flex: 2,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 10),
                                                  ...videoController.tagsList
                                                      .map(
                                                        (e) => SpringWidget(
                                                          onTap: () {
                                                            videoController
                                                                .selectedTags
                                                                .value = e.tags;
                                                            videoController
                                                                .getReelsbyatg(
                                                                    e.tags);
                                                          },
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            child:
                                                                BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX: 5,
                                                                      sigmaY:
                                                                          5),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  color: videoController
                                                                          .selectedTags
                                                                          .contains(e
                                                                              .tags)
                                                                      ? Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.2)
                                                                      : Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.2),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          15),
                                                                  child: Text(
                                                                    e.tags,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          10.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ).paddingSymmetric(
                                                            horizontal: 5),
                                                      )
                                                      .toList(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

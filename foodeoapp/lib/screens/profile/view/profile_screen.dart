import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/helper/internet_controller.dart';
import 'package:foodeoapp/helper/internet_screen.dart';
import 'package:foodeoapp/screens/profile/viewmodel/profile_view_model.dart';
import 'package:foodeoapp/screens/profile/view/profile_setting_screen.dart';
import 'package:foodeoapp/screens/profile/widget/profile_counts.dart';
import 'package:foodeoapp/screens/profile/widget/reels_card.dart';
import 'package:foodeoapp/screens/videos/view/add_reels_screen.dart';
import 'package:foodeoapp/screens/videos/view/viewReel_screen.dart';
import 'package:get/get.dart';

import '../../../components/small_loader.dart';

class ProfileScreen extends StatelessWidget {
  final int restaurantId;
  ProfileScreen({super.key, this.restaurantId = 0});
  final profileController = Get.put(ProfileViewModel());
  final internetController = Get.put(InternetController());
  @override
  Widget build(BuildContext context) {
    log("${restaurantId}");
    if (restaurantId != 0 || restaurantId == null) {
      profileController.getProfileData(restaurantId);
    } else {
      profileController.getrestaurantProfileData();
    }
    return GetBuilder<ThemeHelper>(
      builder: (themeController) => AnnotatedRegion(
        value: themeController.systemUiOverlayStyleForGradient,
        child: SafeArea(
          child: Obx(
            () => internetController.isInternetConnected.isFalse
                ? NoInternetScreen(
                    onTap: () {
                      internetController.internetCheckerFun();
                    },
                  )
                : Scaffold(
                    backgroundColor: themeController.bgcolor,
                    floatingActionButton: DataStroge.userRole.value == 'owner'
                        ? SpringWidget(
                            onTap: () {
                              Navigation.getInstance
                                  .screenNavigation(context, AddReelsScreen());

                              // Navigation.getInstance.screenNavigation(
                              //     context, EditRestaurantProfileScreen());
                            },
                            child: CircleAvatar(
                                radius: 30.sp,
                                backgroundColor: themeController.colorPrimary,
                                child: SvgPicture.asset(
                                  "assets/icons/dish.svg",
                                  height: 30,
                                )),
                          )
                        : const SizedBox(),

                    body: Obx(
                      () => Visibility(
                        visible: profileController.Isloading.isFalse,
                        replacement: const SmallLoader(),
                        child: profileController.RestaurantList.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Data not loaded',
                                      style: TextStyle(
                                        color: themeController.textcolor,
                                      ),
                                    ),
                                    SpringWidget(
                                      onTap: () {
                                        log("${restaurantId}");
                                        if (restaurantId != 0 ||
                                            restaurantId == null) {
                                          profileController
                                              .getProfileData(restaurantId);
                                        } else {
                                          profileController
                                              .getrestaurantProfileData();
                                        }
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            themeController.colorPrimary,
                                        child: const Icon(Icons.restart_alt),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                child: CustomScrollView(
                                  slivers: <Widget>[
                                    SliverAppBar(
                                      leading: DataStroge.userRole.value ==
                                              'user'
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: Constants
                                                        .screenPadding),
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      themeController
                                                          .colorwhite,
                                                  child: Icon(
                                                    Icons.arrow_back,
                                                    color: themeController
                                                        .textcolor,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      actions: [
                                        DataStroge.userRole.value == 'owner'
                                            ? SpringWidget(
                                                onTap: () {
                                                  Navigation.getInstance
                                                      .screenNavigation(context,
                                                          ProfileSettingScreen());
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: Constants
                                                              .screenPadding),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        themeController
                                                            .colorwhite,
                                                    child: Icon(
                                                      Icons.menu,
                                                      color: themeController
                                                          .textcolor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                      backgroundColor: themeController.bgcolor,
                                      expandedHeight:
                                          260.sp, // Adjust as needed
                                      floating: false,
                                      pinned: false,
                                      flexibleSpace: FlexibleSpaceBar(
                                        background: Container(
                                          decoration: BoxDecoration(
                                            gradient: themeController
                                                .containerGradient,
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(40),
                                              bottomRight: Radius.circular(40),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              // First Row: Profile Picture, Follower, Following, and Post Count
                                              SizedBox(
                                                height: 80.sp,
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: Constants
                                                        .screenPadding),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 50.0,
                                                      backgroundImage: NetworkImage(
                                                          profileController
                                                                  .RestaurantList
                                                                  .isEmpty
                                                              ? DataStroge
                                                                  .userImage
                                                                  .value
                                                              : profileController
                                                                  .RestaurantList
                                                                  .first
                                                                  .restaurantImage),
                                                    ),
                                                    const SizedBox(width: 20.0),
                                                    profileCount(
                                                        showIcon: true,
                                                        icon:
                                                            "assets/icons/dishes.svg",
                                                        iconColor:
                                                            themeController
                                                                .colorPrimary,
                                                        title: 'Dishes',
                                                        count: profileController
                                                                .VideoContentList
                                                                .isEmpty
                                                            ? '0'
                                                            : profileController
                                                                .VideoContentList
                                                                .length
                                                                .toString()
                                                        // dishes are not coming from backend
                                                        //  profileController
                                                        //     .RestaurantList
                                                        //     .first
                                                        //     .dishes
                                                        //     .toString()
                                                        ),
                                                    profileCount(
                                                        showIcon: true,
                                                        icon:
                                                            "assets/icons/likes.svg",
                                                        title: 'yummies',
                                                        count: profileController
                                                                .RestaurantList
                                                                .isEmpty
                                                            ? '0'
                                                            : profileController
                                                                .RestaurantList
                                                                .first
                                                                .yummiesCount
                                                                .toString()),
                                                    profileCount(
                                                        showIcon: false,
                                                        icon:
                                                            "assets/icons/star.svg",
                                                        title: 'orders',
                                                        count: profileController
                                                                .RestaurantList
                                                                .isEmpty
                                                            ? '0'
                                                            : profileController
                                                                .RestaurantList
                                                                .first
                                                                .ordersCount
                                                                .toString()),
                                                  ],
                                                ),
                                              ),
                                              // Second Row: Name and Filter Tabs
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: Constants
                                                        .screenPadding),
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: DataStroge.userRole
                                                                .value ==
                                                            'owner'
                                                        ? Text(
                                                            profileController
                                                                        .RestaurantList
                                                                        .first
                                                                        .ownerName ==
                                                                    ''
                                                                ? DataStroge
                                                                    .userName
                                                                    .value
                                                                : profileController
                                                                    .RestaurantList
                                                                    .first
                                                                    .ownerName,
                                                            style: TextStyle(
                                                              fontSize: 20.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ))
                                                        : Text(
                                                            profileController
                                                                        .RestaurantList
                                                                        .first
                                                                        .ownerName ==
                                                                    ''
                                                                ? 'Restaurant'
                                                                : profileController
                                                                    .RestaurantList
                                                                    .first
                                                                    .ownerName,
                                                            style: TextStyle(
                                                              fontSize: 20.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ))),
                                              ),
                                              // .pOnly(left: Constants.screenPadding),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: Constants
                                                        .screenPadding),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: DataStroge.userRole.value == 'owner'
                                                      ? Text(
                                                          profileController.RestaurantList.first.ownerName == ''
                                                              ? '@${DataStroge.userName}'
                                                              : "@${profileController.RestaurantList.first.ownerName}",
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: themeController
                                                                  .textcolor
                                                                  .withOpacity(
                                                                      0.5)))
                                                      : Text(
                                                          profileController.RestaurantList.first.ownerName == ''
                                                              ? '@Restaurant'
                                                              : "@${profileController.RestaurantList.first.ownerName}",
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: themeController.textcolor.withOpacity(0.5))),
                                                ),
                                              ),

                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left:
                                                        Constants.screenPadding,
                                                    right: Constants
                                                        .screenPadding),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      profileController
                                                          .RestaurantList
                                                          .first
                                                          .restaurantBio,
                                                      style: TextStyle(
                                                          fontSize: 12.sp)),
                                                ),
                                              ),
                                              // .pOnly(
                                              //     left: Constants.screenPadding,
                                              //     right: Constants.screenPadding),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SliverPadding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: Constants.screenPadding),
                                      sliver: profileController
                                              .VideoContentList.isEmpty
                                          ? SliverToBoxAdapter(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 60.sp,
                                                  ),
                                                  Container(
                                                    child: Image.asset(
                                                      'assets/images/emtyReel.png',
                                                      height: 130.sp,
                                                      // width: 100,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 250.sp,
                                                    child: Text(
                                                      "It appears the restaurant creator hasn't added any menu items to their profile yet. ",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: themeController
                                                              .textcolor),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : SliverGrid(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      childAspectRatio: 0.7),
                                              delegate:
                                                  SliverChildBuilderDelegate(
                                                childCount: profileController
                                                    .VideoContentList.length,
                                                (context, index) {
                                                  // Create your grid items here (e.g., images from your posts)
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: SpringWidget(
                                                      onTap: () {
                                                        Navigation.getInstance
                                                            .screenNavigation(
                                                                context,
                                                                ViewReelScreen(
                                                                    videoData: profileController
                                                                            .VideoContentList[
                                                                        index]));
                                                      },
                                                      child: reelsCard(
                                                        url: profileController
                                                            .VideoContentList[
                                                                index]
                                                            .thumbnail!,
                                                        onTap: () {},
                                                        yummiesCount:
                                                            profileController
                                                                .VideoContentList[
                                                                    index]
                                                                .yummiesCount!,
                                                      ),
                                                    ),
                                                  );
                                                  // .p(5);
                                                },
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    // ),
                    // ),
                  ),
          ),
        ),
      ),
    );
  }
}

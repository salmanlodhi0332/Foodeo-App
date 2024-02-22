import 'package:animated/animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/screens/homepage/viewmodel/home_view_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:get/get_utils/src/extensions/internacionalization.dart';

class HomeScreen extends StatefulWidget {
  final int? initialIndex;

  HomeScreen({this.initialIndex});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentintex = 0;

  @override
  final homeController = Get.put(HomeViewModel());
  Widget build(BuildContext context) {
    return
        //  Obx(
        //   () =>
        //   internetController.isInternetConnected == false
        //       ? NoInternetScreen(
        //           onTap: () {
        //             checkInternet();
        //           },
        //         )
        //       :
        Scaffold(
            body: homeController.currentScreen
                .elementAt(homeController.selectedIndex.value),
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                height: 100,
                color: Colors.white,
                child: Row(
                  children: [
                    createTabButton(
                      context,
                      title: "profile",
                      icon: "assets/icons/user.svg",
                      inactiveIcon: "assets/icons/user_outlined.svg",
                      selected: homeController.selectedIndex.value == 1,
                      onTap: () async {
                        // if (DataStorage.getInstance.currentSession != null) {

                        homeController.selectedIndex.value = 1;

                        // } else {
                        //   widget.onJoinCall();
                        // }
                      },
                    ),
                    createTabButton(
                      context,
                      title: "profile",
                      icon: "assets/icons/user.svg",
                      inactiveIcon: "assets/icons/user_outlined.svg",
                      selected: homeController.selectedIndex.value == 3,
                      onTap: () async {
                        // if (DataStorage.getInstance.currentSession != null) {

                        homeController.selectedIndex.value = 2;

                        // } else {
                        //   widget.onJoinCall();
                        // }
                      },
                    ),
                    createTabButton(
                      context,
                      title: "profile",
                      icon: "assets/icons/user.svg",
                      inactiveIcon: "assets/icons/user_outlined.svg",
                      selected: homeController.selectedIndex.value == 4,
                      onTap: () async {
                        // if (DataStorage.getInstance.currentSession != null) {

                        homeController.selectedIndex.value = 3;

                        //   widget.tabChanged(4);
                        // } else {
                        //   widget.onJoinCall();
                        // }
                      },
                    ),
                    createTabButton(
                      context,
                      title: "profile",
                      icon: "assets/icons/user.svg",
                      inactiveIcon: "assets/icons/user_outlined.svg",
                      selected: homeController.selectedIndex.value == 4,
                      onTap: () async {
                        // if (DataStorage.getInstance.currentSession != null) {

                        homeController.selectedIndex.value = 4;

                        // widget.tabChanged(4);
                        // } else {
                        //   widget.onJoinCall();
                        // }
                      },
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget createTabButton(
    BuildContext context, {
    required String title,
    required String icon,
    required String inactiveIcon,
    bool selected = false,
    required VoidCallback onTap,
    double size = 25,
    int badgeCount = 0,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AbsorbPointer(
          child: Animated(
            value: selected ? 1 : 0.9,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 300),
            builder: (context, child, animation) => Transform.scale(
              scale: animation.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // badge.Badge(
                  //   showBadge: badgeCount > 0,
                  //   badgeContent:
                  //   Text(
                  //     badgeCount.toString(),
                  //     style: const TextStyle(
                  //         fontSize: 10,
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.w600),
                  //   ),
                  //   child:
                  SvgPicture.asset(selected ? icon : inactiveIcon,
                      height: size,
                      width: size,
                      color: selected ? Colors.amberAccent : Colors.red[350]),
                  // ),
                  const SizedBox(height: 6.5),
                  FittedBox(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                            selected ? FontWeight.bold : FontWeight.w500,
                        color: selected ? Colors.amberAccent : Colors.grey[350],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

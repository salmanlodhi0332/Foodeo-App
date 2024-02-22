import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/screens/authentication/view/join_bottomsheet.dart';
import 'package:foodeoapp/screens/authentication/view_model/auth_view_model.dart';
import 'package:foodeoapp/screens/profile/viewmodel/profile_view_model.dart';
import 'package:foodeoapp/screens/profile/view/edit_restaurantprofile_screen.dart';
import 'package:foodeoapp/screens/profile/view/edit_userprofile_screen.dart';
import 'package:foodeoapp/screens/profile/widget/setting_tile.dart';
import 'package:get/get.dart';
import '../../../components/spring_widget.dart';

import '../../receivedorder/view/restaurant_order_screen.dart';

class ProfileSettingScreen extends StatelessWidget {
  ProfileSettingScreen({
    super.key,
  });

  final ProfileController = Get.put(ProfileViewModel());
  final authController = Get.put(AuthViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
      builder: (themeController) => AnnotatedRegion(
        value: themeController.systemUiOverlayStyleForGradient,
        child: SafeArea(
          child: Scaffold(
            body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: themeController.containerGradient,
                  // color: Colors.amber
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.screenPadding),
                  child: Column(
                    children: [
                      CustomAppBar(
                        appbarpadding: false,
                        leading: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            CircleAvatar(
                              radius: 30.sp,
                              backgroundImage: DataStroge.userToken.value != ''
                                  ? DataStroge.userImage.value != 'null'
                                      ? NetworkImage(DataStroge.userImage.value)
                                      : const NetworkImage(
                                          'https://i.stack.imgur.com/l60Hf.png',
                                        )
                                  : const NetworkImage(
                                      'https://i.stack.imgur.com/l60Hf.png',
                                    ),
                            ),
                            SizedBox(
                              width: 15.sp,
                            ),
                            DataStroge.userToken.value != ''
                                ? Text(DataStroge.userName.value,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold))
                                : Text('Guest User',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.sp,
                      ),
                      setting_tile(
                          onTap: () {
                            if (DataStroge.userToken.value == '') {
                              Get.bottomSheet(JoinBottomSheet());
                            } else {
                              if (DataStroge.userRole.value == 'owner') {
                                ProfileController
                                    .getrestaurantEditProfileData();
                                Navigation.getInstance.screenNavigation(
                                    context, EditRestaurantProfileScreen());
                              } else {
                                Navigation.getInstance.screenNavigation(
                                    context, EditUserProfileScreen());
                              }
                            }
                          },
                          name: 'My Profile',
                          leadingSVG: 'assets/icons/user-outline.svg',
                          showtrailing: true),
                      // if (DataStroge.userRole.value == 'owner')
                      //   setting_tile(
                      //       onTap: () {
                      //         Navigation.getInstance.RightToLeft_PageNavigation(
                      //             context, const AddressScreen());
                      //       },
                      //       name: 'Address',
                      //       leadingSVG: 'assets/icons/address.svg',
                      //       showtrailing: true),
                      if (DataStroge.userRole.value == 'owner')
                        setting_tile(
                            onTap: () {
                              Navigation.getInstance.screenNavigation(
                                  context, RestaurantOrderScreen());
                            },
                            name: 'Order Received',
                            leadingSVG: 'assets/icons/cart.svg',
                            showtrailing: true),
                      if (DataStroge.userRole.value == 'user')
                        setting_tile(
                            onTap: () {
                              // Navigation.getInstance
                              //     .screenNavigation(context, UserOrderScreen());
                            },
                            name: 'My Order',
                            leadingSVG: 'assets/icons/cart.svg',
                            showtrailing: true),
                      // if (DataStroge.userRole.value == 'owner')
                      //   setting_tile(
                      //       onTap: () {
                      //         Get.to(AddReelsScreen());
                      //       },
                      //       name: 'Payment Methods',
                      //       leadingSVG: 'assets/icons/payment.svg',
                      // //       showtrailing: true),
                      // if (DataStroge.userToken.value != '')
                      //   setting_tile(
                      //       onTap: () {},
                      //       name: 'Notification',
                      //       leadingSVG: 'assets/icons/bell.svg',
                      //       showtrailing: true),
                      setting_tile(
                          onTap: () {
                            // Navigation.getInstance
                            //     .screenNavigation(context, VideoTesting());
                          },
                          name: 'Terms and Conditions',
                          leadingSVG: 'assets/icons/terms.svg',
                          showtrailing: true),
                      if (DataStroge.userToken.value != '')
                        setting_tile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(35.0)),
                                  child: Container(
                                    padding: EdgeInsets.all(30.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Logout?",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Text(
                                            "Are you sure you want to logout?",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color:
                                                    themeController.textcolor2),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: SpringWidget(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.sp),
                                                    decoration: BoxDecoration(),
                                                    child: Center(
                                                      child: Text(
                                                        "Cencel",
                                                        style: TextStyle(
                                                            color: themeController
                                                                .colorPrimary,
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 12.sp,
                                            ),
                                            Expanded(
                                              child: SpringWidget(
                                                  onTap: () {
                                                    log('messageLogout');
                                                    authController
                                                        .logout(context);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.sp),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: themeController
                                                          .colorPrimary,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Logout",
                                                        style: TextStyle(
                                                            color:
                                                                themeController
                                                                    .colorwhite,
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            name: 'Logout',
                            LeadingColor: Colors.red,
                            nameColor: Colors.red,
                            leadingSVG: 'assets/icons/logout.svg',
                            showtrailing: false),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

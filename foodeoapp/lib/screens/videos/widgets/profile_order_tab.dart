import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/screens/addproduct/view/product_detail_screen.dart';
import 'package:foodeoapp/screens/authentication/view/join_bottomsheet.dart';
import 'package:foodeoapp/screens/ordersummary/view/order_summary_screen.dart';
import 'package:get/get.dart';
import '../../profile/view/profile_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    Key? key,
    required this.username,
    required this.productPrice,
    required this.userId,
    required this.restaurantId,
    required this.productId,
    required this.productname,
    required this.userPicture,
    required this.reelId,
  }) : super(key: key);

  final String username;
  final String userPicture;
  final String productPrice;
  final int userId;
  final int restaurantId;
  final int productId;
  final int reelId;
  final String productname;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeHelper());

    return Container(
      height: 90,
      width: 325.sp,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.1), // Adjust opacity as needed
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListTile(
                  leading: GestureDetector(
                    onTap: () async {
                      //   final ProfileViewModel restaurant = ProfileViewModel();
                      // await restaurant.getProfileData(2);
                      print(restaurantId);
                      Navigation.getInstance.screenNavigation(
                          context,
                          ProfileScreen(
                            restaurantId: restaurantId,
                          ));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: ImageWidget(
                        imageUrl: userPicture,
                        width: 60,
                      ),
                    ),
                  ),
                  title: Text(
                    productname + '   \$' + productPrice,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  subtitle: Text(
                    'by $username',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  trailing: SpringWidget(
                    onTap: () {
                      if (DataStroge.userToken == '') {
                        Get.bottomSheet(JoinBottomSheet());
                      } else {
                        Navigation.getInstance.screenNavigation(
                            context, OrderSummaryScreen(productId: productId));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: themeController.backgroundGradient,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Order now',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

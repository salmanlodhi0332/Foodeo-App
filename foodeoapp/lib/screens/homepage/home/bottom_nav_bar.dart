// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter/material.dart';
// import 'package:foodeoapp/screens/ordersummary/view/order_summary_screen.dart';
// import 'package:foodeoapp/screens/explorepage/view/explore_screen.dart';
// import 'package:foodeoapp/screens/videos/view/videoreels_screen.dart';
// import 'package:get/get.dart';

// import '../../../constant/theme.dart';
// import '../../profile/view/profile_setting_screen.dart';

// class BottomNavBar extends StatefulWidget {
//   final int? initialIndex;
//   BottomNavBar({this.initialIndex});
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int _currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       _currentIndex = widget.initialIndex ?? _currentIndex;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ThemeHelper>(
//         builder: (themeController) => AnnotatedRegion(
//               value: const SystemUiOverlayStyle(
//                 systemNavigationBarColor: Colors.white,
//               ),
//               child: Scaffold(
//                 extendBody: true,
//                 body: _buildPage(_currentIndex),
//                 bottomNavigationBar: Container(
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(30),
//                           topLeft: Radius.circular(30)),
//                     ),
//                     child: Material(
//                       elevation: 0.0,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0)),
//                       child: BottomNavigationBar(
//                         elevation: 0,
//                         backgroundColor: Colors.transparent,
//                         currentIndex: _currentIndex,
//                         selectedIconTheme:
//                             IconThemeData(color: themeController.colorPrimary),
//                         unselectedIconTheme: IconThemeData(
//                           color: themeController.bottomiconcolor,
//                         ),
//                         selectedItemColor: themeController.colorPrimary,
//                         unselectedItemColor: themeController.bottomiconcolor,
//                         selectedLabelStyle: TextStyle(
//                             color: themeController.colorPrimary,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 12.sp),
//                         unselectedLabelStyle: TextStyle(
//                             color: themeController.bottomiconcolor,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 10.sp),
//                         onTap: (index) {
//                           setState(() {
//                             _currentIndex = index;
//                           });
//                         },
//                         type: BottomNavigationBarType.fixed,
//                         items: <BottomNavigationBarItem>[
//                           BottomNavigationBarItem(
//                             icon: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: _currentIndex == 0
//                                   ? SvgPicture.asset(
//                                       "assets/icons/home.svg",
//                                       height: 20,
//                                       width: 20,
//                                     )
//                                   : SvgPicture.asset(
//                                       "assets/icons/homeb.svg",
//                                       height: 17,
//                                       width: 17,
//                                       color: themeController.bottomiconcolor,
//                                     ),
//                             ),
//                             label: 'Home'.tr,
//                           ),
//                           BottomNavigationBarItem(
//                             icon: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: _currentIndex == 1
//                                   ? SvgPicture.asset(
//                                       "assets/icons/searchb.svg",
//                                       height: 20,
//                                       width: 20,
//                                     )
//                                   : SvgPicture.asset(
//                                       "assets/icons/search.svg",
//                                       height: 17,
//                                       width: 17,

//                                       color: themeController.bottomiconcolor,
//                                       // color: Theme.of(context).disabledColor,
//                                     ),
//                             ),
//                             label: 'Explore'.tr,
//                           ),
//                           BottomNavigationBarItem(
//                             icon: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: _currentIndex == 2
//                                   ? SvgPicture.asset(
//                                       "assets/icons/cart_fill.svg",
//                                       height: 20,
//                                       width: 20,
//                                     )
//                                   : SvgPicture.asset(
//                                       "assets/icons/cart.svg",
//                                       height: 17,
//                                       width: 17,
//                                       color: themeController.bottomiconcolor,
//                                     ),
//                             ),
//                             label: 'Cart'.tr,
//                           ),
//                           BottomNavigationBarItem(
//                             icon: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: _currentIndex == 3
//                                   ? SvgPicture.asset(
//                                       "assets/icons/user.svg",
//                                       height: 20,
//                                       width: 20,
//                                       color: themeController.colorPrimary,
//                                     )
//                                   : SvgPicture.asset(
//                                       "assets/icons/userb.svg",
//                                       height: 17,
//                                       width: 17,
//                                       color: themeController.bottomiconcolor,
//                                     ),
//                             ),
//                             label: 'Profile'.tr,
//                           ),
//                         ],
//                       ),
//                     )),

//                 //  Container(
//                 //   decoration: BoxDecoration(
//                 //     color: Colors.red,
//                 //     borderRadius: BorderRadius.only(
//                 //         topRight: Radius.circular(30), topLeft: Radius.circular(30)),
//                 //   ),
//                 //   child: Material(
//                 //     elevation: 0.0,
//                 //     shape:
//                 //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//                 //     child: BottomNavigationBar(
//                 //       backgroundColor: Colors.transparent,
//                 //       currentIndex: _currentIndex,
//                 //       // selectedIconTheme:
//                 //       //     IconThemeData(color: Theme.of(context).hoverColor),
//                 //       // unselectedIconTheme:
//                 //       //     IconThemeData(color: Theme.of(context).disabledColor),
//                 //       // selectedItemColor: Theme.of(context).hoverColor,
//                 //       // unselectedItemColor: Theme.of(context).disabledColor,
//                 //       // selectedLabelStyle: TextStyle(
//                 //       //     color: Theme.of(context).hoverColor,
//                 //       //     fontWeight: FontWeight.w700,
//                 //       //     fontSize: 13.sp),
//                 //       // unselectedLabelStyle: TextStyle(
//                 //       //     color: Theme.of(context).disabledColor,
//                 //       //     fontWeight: FontWeight.normal,
//                 //       //     fontSize: 12.sp),
//                 //       // onTap: (index) {
//                 //       //   setState(() {
//                 //       //     _currentIndex = index;
//                 //       //   });
//                 //       // },
//                 //       // type: BottomNavigationBarType.fixed, // To show all labels
//                 //       items: [
//                 //         BottomNavigationBarItem(
//                 //           icon: Padding(
//                 //             padding: const EdgeInsets.all(8.0),
//                 //             child: _currentIndex == 0
//                 //                 ? SvgPicture.asset(
//                 //                     "assets/icons/cart.svg",
//                 //                     height: 18,
//                 //                     width: 18,
//                 //                   )
//                 //                 : SvgPicture.asset(
//                 //                     "assets/icons/cart.svg",
//                 //                     height: 18,
//                 //                     width: 18,
//                 //                     color: Theme.of(context).disabledColor,
//                 //                   ),
//                 //           ),
//                 //           label: 'home'.tr,
//                 //         ),
//                 //         BottomNavigationBarItem(
//                 //           icon: Padding(
//                 //             padding: const EdgeInsets.all(8.0),
//                 //             child: _currentIndex == 1
//                 //                 ? SvgPicture.asset(
//                 //                     "assets/icons/cart.svg",
//                 //                     height: 20,
//                 //                     width: 20,
//                 //                   )
//                 //                 : SvgPicture.asset(
//                 //                     "assets/icons/cart.svg",
//                 //                     height: 17,
//                 //                     width: 17,
//                 //                     color: Theme.of(context).disabledColor,
//                 //                   ),
//                 //           ),
//                 //           label: 'explore'.tr,
//                 //         ),
//                 //         BottomNavigationBarItem(
//                 //           icon: Padding(
//                 //             padding: const EdgeInsets.all(8.0),
//                 //             child: _currentIndex == 2
//                 //                 ? SvgPicture.asset(
//                 //                     "assets/icons/cart.svg",
//                 //                     height: 20,
//                 //                     width: 20,
//                 //                   )
//                 //                 : SvgPicture.asset(
//                 //                     "assets/icons/cart.svg",
//                 //                     height: 20,
//                 //                     width: 20,
//                 //                     color: Theme.of(context).disabledColor,
//                 //                   ),
//                 //           ),
//                 //           label: 'live'.tr,
//                 //         ),
//                 //         BottomNavigationBarItem(
//                 //           icon: Padding(
//                 //             padding: const EdgeInsets.all(8.0),
//                 //             child: _currentIndex == 3
//                 //                 ? SvgPicture.asset(
//                 //                     "assets/icons/cart.svg",
//                 //                     height: 22,
//                 //                     width: 22,
//                 //                   )
//                 //                 : SvgPicture.asset(
//                 //                     "assets/icons/cart.svg",
//                 //                     height: 22,
//                 //                     width: 22,
//                 //                     color: Theme.of(context).disabledColor,
//                 //                   ),
//                 //           ),
//                 //           label: 'cart'.tr,
//                 //         ),
//                 //         // BottomNavigationBarItem(
//                 //         //   icon: Padding(
//                 //         //     padding: const EdgeInsets.all(8.0),
//                 //         //     child: _currentIndex == 4
//                 //         //         ? SvgPicture.asset(
//                 //         //             "assets/icons/cart.svg",
//                 //         //             height: 20,
//                 //         //             width: 20,
//                 //         //           )
//                 //         //         : SvgPicture.asset(
//                 //         //             "assets/icons/cart.svg",
//                 //         //             height: 20,
//                 //         //             width: 20,
//                 //         //             color: Theme.of(context).disabledColor,
//                 //         //           ),
//                 //         //   ),
//                 //         //   label: 'Profile',
//                 //         // ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//               ),
//             ));
//   }

//   // final cartController = Get.put(cart_Controller());
//   Widget _buildPage(int index) {
//     // You can return different widgets/screens based on the index
//     switch (index) {
//       case 0:
//         return VideoReelsScreen();
//       case 1:
//         return exporepage();
//       case 2:
//         return OrderSummaryScreen();
//       case 3:
//         return ProfileSettingScreen();
//       default:
//         return VideoReelsScreen();
//     }
//   }
// }


























//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: _buildPage(_currentIndex),
//   //     bottomNavigationBar: BottomNavigationBar(
//   //       currentIndex: _currentIndex,
//   //       selectedIconTheme: IconThemeData(color: Theme.of(context).hoverColor),
//   //       unselectedIconTheme:
//   //           IconThemeData(color: Theme.of(context).disabledColor),
//   //       selectedItemColor: Theme.of(context).hoverColor,
//   //       unselectedItemColor: Theme.of(context).disabledColor,
//   //       selectedLabelStyle: TextStyle(
//   //           color: Theme.of(context).hoverColor,
//   //           fontWeight: FontWeight.w700,
//   //           fontSize: 13.sp),
//   //       unselectedLabelStyle: TextStyle(
//   //           color: Theme.of(context).disabledColor,
//   //           fontWeight: FontWeight.normal,
//   //           fontSize: 12.sp),
//   //       onTap: (index) {
//   //         setState(() {
//   //           _currentIndex = index;
//   //         });
//   //       },
//   //       type: BottomNavigationBarType.fixed, // To show all labels
//   //       items: [
//   //         BottomNavigationBarItem(
//   //           icon: Padding(
//   //             padding: const EdgeInsets.all(8.0),
//   //             child: _currentIndex == 0
//   //                 ? SvgPicture.asset(
//   //                     "assets/svg/homebg.svg",
//   //                     height: 18,
//   //                     width: 18,
//   //                   )
//   //                 : SvgPicture.asset(
//   //                     "assets/svg/home.svg",
//   //                     height: 18,
//   //                     width: 18,
//   //                     color: Theme.of(context).disabledColor,
//   //                   ),
//   //           ),
//   //           label: 'home'.tr,
//   //         ),
//   //         BottomNavigationBarItem(
//   //           icon: Padding(
//   //             padding: const EdgeInsets.all(8.0),
//   //             child: _currentIndex == 1
//   //                 ? SvgPicture.asset(
//   //                     "assets/svg/searchbg.svg",
//   //                     height: 20,
//   //                     width: 20,
//   //                   )
//   //                 : SvgPicture.asset(
//   //                     "assets/svg/brower.svg",
//   //                     height: 17,
//   //                     width: 17,
//   //                     color: Theme.of(context).disabledColor,
//   //                   ),
//   //           ),
//   //           label: 'explore'.tr,
//   //         ),
//   //         BottomNavigationBarItem(
//   //           icon: Padding(
//   //             padding: const EdgeInsets.all(8.0),
//   //             child: _currentIndex == 2
//   //                 ? SvgPicture.asset(
//   //                     "assets/svg/wishlistbg.svg",
//   //                     height: 20,
//   //                     width: 20,
//   //                   )
//   //                 : SvgPicture.asset(
//   //                     "assets/svg/wishlist.svg",
//   //                     height: 20,
//   //                     width: 20,
//   //                     color: Theme.of(context).disabledColor,
//   //                   ),
//   //           ),
//   //           label: 'live'.tr,
//   //         ),
//   //         BottomNavigationBarItem(
//   //           icon: Padding(
//   //             padding: const EdgeInsets.all(8.0),
//   //             child: _currentIndex == 3
//   //                 ? SvgPicture.asset(
//   //                     "assets/svg/cartbg.svg",
//   //                     height: 22,
//   //                     width: 22,
//   //                   )
//   //                 : SvgPicture.asset(
//   //                     "assets/svg/cart.svg",
//   //                     height: 22,
//   //                     width: 22,
//   //                     color: Theme.of(context).disabledColor,
//   //                   ),
//   //           ),
//   //           label: 'cart'.tr,
//   //         ),
//   //         BottomNavigationBarItem(
//   //           icon: Padding(
//   //             padding: const EdgeInsets.all(8.0),
//   //             child: _currentIndex == 4
//   //                 ? SvgPicture.asset(
//   //                     "assets/svg/profilebg.svg",
//   //                     height: 20,
//   //                     width: 20,
//   //                   )
//   //                 : SvgPicture.asset(
//   //                     "assets/svg/profile.svg",
//   //                     height: 20,
//   //                     width: 20,
//   //                     color: Theme.of(context).disabledColor,
//   //                   ),
//   //           ),
//   //           label: 'Profile',
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
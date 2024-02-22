// import 'dart:math';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:foodeoapp/components/custom_appbar.dart';
// import 'package:foodeoapp/components/image_widget.dart';
// import 'package:foodeoapp/components/small_loader.dart';
// import 'package:foodeoapp/components/spring_widget.dart';
// import 'package:foodeoapp/constant/constants.dart';
// import 'package:foodeoapp/constant/navigation.dart';
// import 'package:foodeoapp/constant/theme.dart';
// import 'package:foodeoapp/screens/addproduct/view/product_detail_screen.dart';
// import 'package:foodeoapp/screens/explorepage/view/popular_screen.dart';
// import 'package:foodeoapp/screens/explorepage/view/recommended_screen.dart';
// import 'package:foodeoapp/screens/explorepage/view/search_screen.dart';
// import 'package:foodeoapp/screens/explorepage/viewModel/explore_view_model.dart';
// import 'package:foodeoapp/screens/explorepage/widget/categoryCard.dart';
// import 'package:foodeoapp/screens/explorepage/widget/popularproductcard.dart';
// import 'package:foodeoapp/screens/explorepage/widget/productcard.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';

// class exporepage extends StatelessWidget {
//   exporepage({super.key});

//   @override
//   final exploreController = Get.put(ExploreViewModel());
//   Widget build(BuildContext context) {
//     return GetBuilder<ThemeHelper>(
//       builder: (themeController) => AnnotatedRegion(
//         value: themeController.systemUiOverlayStyleForwhite,
//         child: GetBuilder<ExploreViewModel>(
//           init: ExploreViewModel(),
//           builder: (explore) => Container(
//             child: SafeArea(
//               child: Scaffold(
//                 backgroundColor: themeController.bgcolor,
//                 body: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: Constants.screenPadding),
//                     child: Column(children: [
//                       SizedBox(
//                         height: 10.sp,
//                       ),
//                       Text(
//                         'Explore',
//                         style: TextStyle(
//                             color: themeController.textcolor,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(
//                         height: 20.sp,
//                       ),
//                       SpringWidget(
//                         onTap: () {
//                           Navigation.getInstance
//                               .screenNavigation(context, SearchProductScreen());
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Colors.white),
//                           child: ListTile(
//                             leading: Icon(
//                               Icons.search,
//                               color: themeController.colorIcon.withOpacity(0.4),
//                             ),
//                             title: Text(
//                               'search restaurant..',
//                               style: TextStyle(
//                                   color: themeController.textcolor,
//                                   fontSize: 12.sp),
//                             ),
//                           ),
//                         ),
//                       ),
//                       ListTile(
//                         leading: Text(
//                           'Popular 👌',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         trailing: SpringWidget(
//                           onTap: () {
//                             Navigation.getInstance
//                                 .screenNavigation(context, PopularScreen());
//                           },
//                           child: Text(
//                             'See All',
//                             style:
//                                 TextStyle(color: Colors.red, fontSize: 13.sp),
//                           ),
//                         ),
//                       ),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Obx(
//                           () => exploreController.PopularProductList.isEmpty
//                               ? Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     SizedBox(
//                                       height: 100.sp,
//                                     ),
//                                     Text('Recommended Data not loaded')
//                                   ],
//                                 )
//                               : Row(
//                                   children: exploreController.PopularProductList
//                                       .map((e) => SpringWidget(
//                                             onTap: () {
//                                               Navigation.getInstance
//                                                   .screenNavigation(
//                                                       context,
//                                                       ProductDetailScreen(
//                                                         productId: e.productId,
//                                                       ));
//                                             },
//                                             child: productcard(
//                                               image: e.productImage,
//                                               name: e.productName,
//                                               distance:
//                                                   e.deliveryRadius.toString(),
//                                               deliverycharges:
//                                                   e.deliveryCharges.toString(),
//                                               price: e.productPrice.toString(),
//                                               rating:
//                                                   e.ratingsAverage.toString(),
//                                               reviewsCount:
//                                                   e.reviewsCount.toString(),
//                                               restaurantImage:
//                                                   e.restaurantImage,
//                                             ),
//                                           )).toList(),
//                                 ),
//                         ),
//                       ),
//                       ListTile(
//                         leading: Text(
//                           'recommended For You 🔥',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         trailing: SpringWidget(
//                           onTap: () {
//                             Navigation.getInstance
//                                 .screenNavigation(context, RecommendedScreen());
//                           },
//                           child: Text(
//                             'See All',
//                             style:
//                                 TextStyle(color: Colors.red, fontSize: 13.sp),
//                           ),
//                         ),
//                       ),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Obx(
//                           () => exploreController.tagsList.isEmpty
//                               ? Row(
//                                   children: [Text('Tags Data not loaded')],
//                                 )
//                               : Row(children: [
//                                   categorybtn(
//                                     image: '',
//                                     name: '  All  ',
//                                     onTap: () {
//                                       exploreController.selectedTags.value =
//                                           '  All  ';
//                                     },
//                                   ),
//                                   SizedBox(
//                                     width: 1.sp,
//                                   ),
//                                   ...exploreController.tagsList
//                                       .map(
//                                         (e) => categorybtn(
//                                           image: '',
//                                           name: e.tags,
//                                           onTap: () {
//                                             exploreController
//                                                 .selectedTags.value = e.tags;
//                                             exploreController
//                                                 .getRecommendedProductDataByTag(
//                                                     e.tags);
//                                           },
//                                         ),
//                                       )
//                                       .toList()
//                                 ]),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.sp,
//                       ),
//                       Obx(
//                         () => exploreController
//                                 .RecommendedProductIsloading.value
//                             ? SmallLoader()
//                             : exploreController.RecommendedProductList.isEmpty
//                                 ? Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       SizedBox(
//                                         height: 200.sp,
//                                       ),
//                                       Text('Recommended Data not loaded')
//                                     ],
//                                   )
//                                 : Column(
//                                     children: exploreController
//                                             .RecommendedProductList
//                                         .map((e) => SpringWidget(
//                                               onTap: () {
//                                                 Navigation.getInstance
//                                                     .screenNavigation(
//                                                         context,
//                                                         ProductDetailScreen(
//                                                           productId:
//                                                               e.productId,
//                                                         ));
//                                               },
//                                               child: popularproductCard(
//                                                   image: e.productImage,
//                                                   name: e.productName,
//                                                   distance: e.deliveryRadius,
//                                                   rating: e.ratingsAverage,
//                                                   reviewsCount: e.reviewsCount,
//                                                   price: e.productPrice,
//                                                   deliverycharges:
//                                                       e.deliveryCharges,
//                                                   restaurantImage:
//                                                       e.restaurantImage,
//                                                   deliveryRadius:
//                                                       e.deliveryRadius),
//                                             )).toList()),
//                       ),
//                     ]),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

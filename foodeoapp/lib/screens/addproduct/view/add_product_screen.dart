// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:foodeoapp/components/custom_appbar.dart';
// import 'package:foodeoapp/components/custom_textfiled.dart';
// import 'package:foodeoapp/components/image_picker_bottom_sheet.dart';
// import 'package:foodeoapp/components/image_widget.dart';
// import 'package:foodeoapp/components/spring_widget.dart';
// import 'package:foodeoapp/constant/constants.dart';
// import 'package:foodeoapp/constant/theme.dart';
// import 'package:foodeoapp/helper/data_storage.dart';
// import 'package:foodeoapp/helper/getx_helper.dart';
// import 'package:foodeoapp/screens/addproduct/viewmodel/addproduct_view_model.dart';

// import 'package:foodeoapp/screens/addproduct/widget/allergence_bottom_sheet.dart';
// import 'package:foodeoapp/screens/explorepage/widget/categoryCard.dart';
// import 'package:foodeoapp/screens/videos/viewModel/video_viewmodel.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';

// class AddProductscreen extends StatelessWidget {
//   AddProductscreen({super.key});

//   @override
//   final controller = Get.put(VideoViewModel());
//   final productnameController = TextEditingController();
//   final productDescriptionController = TextEditingController();
//   final AllergensController = TextEditingController();
//   final NutritionalController = TextEditingController();
//   final caloriesController = TextEditingController();
//   final Productcontroller = Get.put(AddProductViewModel());
//   final controllersProvider = Get.put(GetxControllersProvider());

//   Widget build(BuildContext context) {
//     return GetBuilder<ThemeHelper>(builder: (themecontroller) {
//       return AnnotatedRegion(
//         value: themecontroller.systemUiOverlayStyleForwhite,
//         child: Scaffold(
//           backgroundColor: themecontroller.bgcolor,
//           appBar: CustomAppBar(
//             margin: 0,
//             leading: () {
//               Navigator.pop(context);
//             },
//             title: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                   color: themecontroller.circlecolor.withOpacity(0.5)),
//               child: Padding(
//                 padding: EdgeInsets.all(15),
//                 child:
//                     Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//                   Padding(
//                     padding: EdgeInsets.only(right: 8),
//                     child: CircleAvatar(
//                       radius: 15,
//                       backgroundImage: NetworkImage(
//                         'https://www.eatingwell.com/thmb/088YHsNmHkUQ7iNGP4375MiAXOY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/article_7866255_foods-you-should-eat-every-week-to-lose-weight_-04-d58e9c481bce4a29b47295baade4072d.jpg',
//                       ),
//                     ),
//                   ),
//                   Text(
//                     'Add Product',
//                     style: TextStyle(
//                         color: themecontroller.textcolor,
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w600),
//                   )
//                 ]),
//               ),
//             ),
//           ),
//           body: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: Constants.screenPadding),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 20.sp,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 15.sp, bottom: 10.sp),
//                     child: Text(
//                       'Upload Reel',
//                       style: TextStyle(
//                           color: themecontroller.textcolor,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14.sp),
//                     ),
//                   ),
//                   Obx(
//                     () => SpringWidget(
//                       onTap: () {
//                         controller.getVideoGallery();
//                       },
//                       child: Center(
//                           child: controller.videothembnail.value == ""
//                               ? Container(
//                                   height: 220.sp,
//                                   width: double.maxFinite,
//                                   padding: EdgeInsets.all(90.sp),
//                                   decoration: BoxDecoration(
//                                       color: themecontroller.colorwhite,
//                                       borderRadius:
//                                           BorderRadius.circular(15.sp)),
//                                   child: SvgPicture.asset(
//                                     "assets/icons/upload.svg",
//                                     color: themecontroller.textcolor
//                                         .withOpacity(0.4),
//                                     height: 20.sp,
//                                     width: 15.sp,
//                                   ),
//                                 )
//                               : Container(
//                                   height: 220.sp,
//                                   width: double.maxFinite,
//                                   decoration: BoxDecoration(
//                                       color: themecontroller.colorwhite,
//                                       borderRadius:
//                                           BorderRadius.circular(15.sp),
//                                       image: DecorationImage(
//                                           image: FileImage(File(
//                                               controller.videothembnail.value)),
//                                           fit: BoxFit.cover)),
//                                   // child: Image.file(
//                                   //   File(controller.videothembnail.value),
//                                   //   fit: BoxFit.fill,
//                                   // ),
//                                 )),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.sp,
//                   ),
//                   CustomTextFieldWidget(
//                       fieldColor: themecontroller.colorwhite,
//                       enabled: true,
//                       controller: productnameController,
//                       hintText: 'Product Name',
//                       onsubmit: () {},
//                       inputType: TextInputType.name,
//                       label: 'Add a title'),
//                   SizedBox(
//                     height: 10.sp,
//                   ),
//                   CustomTextFieldWidget(
//                       fieldColor: themecontroller.colorwhite,
//                       enabled: true,
//                       controller: productDescriptionController,
//                       hintText: 'Add description of product here',
//                       onsubmit: () {},
//                       inputType: TextInputType.name,
//                       label: 'Add description'),
//                   SizedBox(
//                     height: 10.sp,
//                   ),
//                   GestureDetector(
//                       onTap: () {
//                         AllergenceBottomSheet.show(context);
//                       },
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Obx(
//                           () => Productcontroller.SelectAllergensList.isEmpty
//                               ? CustomTextFieldWidget(
//                                   fieldColor: themecontroller.colorwhite,
//                                   enabled: false,
//                                   controller: AllergensController,
//                                   hintText: 'Select Allergens',
//                                   onsubmit: () {},
//                                   inputType: TextInputType.name,
//                                   label: 'Add Allergens')
//                               : Row(children: [
//                                   categorybtn(
//                                     image: '',
//                                     name: '  Clear  ',
//                                     onTap: () {
//                                       '  All  ';
//                                     },
//                                   ),
//                                   SizedBox(
//                                     width: 1.sp,
//                                   ),
//                                   ...Productcontroller.SelectAllergensList.map(
//                                     (e) => categorybtn(
//                                       image: '',
//                                       name: e.allergens,
//                                       onTap: () {},
//                                     ),
//                                   ).toList()
//                                 ]),
//                         ),
//                       )),
//                   SizedBox(
//                     height: 10.sp,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                           flex: 2,
//                           child: CustomTextFieldWidget(
//                             fieldColor: themecontroller.colorwhite,
//                             enabled: true,
//                             controller: NutritionalController,
//                             hintText: 'Nutrition name',
//                             onsubmit: () {},
//                             inputType: TextInputType.name,
//                             label: 'Nutritional Values',
//                           )),
//                       SizedBox(
//                         width: 10.sp,
//                       ),
//                       Expanded(
//                           flex: 2,
//                           child: CustomTextFieldWidget(
//                             fieldColor: themecontroller.colorwhite,
//                             enabled: true,
//                             controller: caloriesController,
//                             hintText: 'calories',
//                             onsubmit: () {},
//                             inputType: TextInputType.number,
//                             label: '',
//                           )),
//                       SizedBox(
//                         width: 10.sp,
//                       ),
//                       Expanded(
//                           flex: 1,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               SizedBox(
//                                 height: 25.sp,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Productcontroller.addNutritions(
//                                       caloriesController.text,
//                                       NutritionalController.text);
//                                   NutritionalController.clear();
//                                   caloriesController.clear();
//                                 },
//                                 child: Container(
//                                   width: 50.sp,
//                                   height: 50.sp,
//                                   decoration: BoxDecoration(
//                                     color: themecontroller.circlecolor,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Icon(Icons.add),
//                                 ),
//                               ),
//                             ],
//                           ))
//                     ],
//                   ),
//                   Obx(
//                     () => Visibility(
//                       visible: Productcontroller.NutrientList.isNotEmpty,

//                       child: Column(children: [
//                         SizedBox(
//                           height: 20.sp,
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Nutrition List',
//                             style: TextStyle(
//                                 color: themecontroller.textcolor,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 12.sp),
//                           ),
//                         ),
//                         ListTile(
//                           leading: Text('Nutrition Name' as String),
//                           trailing: Text('Calories' as String),
//                         ),
//                         ...Productcontroller.NutrientList.map(
//                           (e) => Column(
//                             children: [
//                               ListTile(
//                                 leading: Text(e.nutritional_names as String),
//                                 trailing: Text(e.nutritional_values as String),
//                               ),
//                             ],
//                           ),
//                         ).toList(),
//                       ]),

//                       // ListView.builder(
//                       //   itemCount: Productcontroller.NutrientList.length,
//                       //   itemBuilder: (BuildContext context, int index) {
//                       //     return
//                       // ListTile(
//                       //   leading: Text(Productcontroller
//                       //       .NutrientList[index]
//                       //       .nutritional_names as String),
//                       //   trailing: Text(Productcontroller
//                       //       .NutrientList[index]
//                       //       .nutritional_values as String),
//                       // );
//                       //   },
//                       // ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Add Product Addons here',
//                       style: TextStyle(
//                           color: themecontroller.textcolor,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 12.sp),
//                     ),
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Obx(
//                         () => SpringWidget(
//                           onTap: () {
//                             // controllersProvider.getImage();
//                             ImagePickerBottomSheet.show(context, false);
//                           },
//                           child: controllersProvider.imagePath.value.isNotEmpty
//                               ? Container(
//                                   height: 50.sp,
//                                   width: 50.sp,
//                                   padding: EdgeInsets.all(10.sp),
//                                   decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                         fit: BoxFit.cover,
//                                         image: FileImage(
//                                           File(controllersProvider
//                                               .AddimagePath.value),
//                                         ),
//                                       ),
//                                       color: themecontroller.colorwhite,
//                                       borderRadius: BorderRadius.circular(30)),
//                                 )
//                               : Container(
//                                   height: 50.sp,
//                                   width: 50.sp,
//                                   padding: EdgeInsets.all(15.sp),
//                                   child: SvgPicture.asset(
//                                     "assets/icons/upload.svg",
//                                     color: themecontroller.textcolor
//                                         .withOpacity(0.6),
//                                     height: 20.sp,
//                                     width: 15.sp,
//                                   ),
//                                   decoration: BoxDecoration(
//                                       color: themecontroller.colorwhite,
//                                       borderRadius: BorderRadius.circular(30)),
//                                 ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10.sp,
//                       ),
//                       Expanded(
//                           flex: 3,
//                           child: CustomTextFieldWidget(
//                             fieldColor: themecontroller.colorwhite,
//                             enabled: true,
//                             controller: caloriesController,
//                             hintText: 'Enter Add on price',
//                             onsubmit: () {},
//                             inputType: TextInputType.number,
//                             label: '',
//                           )),
//                       // SizedBox(
//                       //   width: 10.sp,
//                       // ),
//                       Expanded(
//                           flex: 1,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               SizedBox(
//                                 height: 25.sp,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Productcontroller.addNutritions(
//                                       caloriesController.text,
//                                       NutritionalController.text);
//                                   NutritionalController.clear();
//                                   caloriesController.clear();
//                                 },
//                                 child: Container(
//                                   width: 50.sp,
//                                   height: 50.sp,
//                                   decoration: BoxDecoration(
//                                     color: themecontroller.circlecolor,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Icon(Icons.add),
//                                 ),
//                               ),
//                             ],
//                           ))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

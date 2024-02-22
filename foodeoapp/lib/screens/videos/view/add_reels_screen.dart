import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';
import 'package:foodeoapp/components/image_picker_bottom_sheet.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/helper/getx_helper.dart';
import 'package:foodeoapp/helper/internet_controller.dart';
import 'package:foodeoapp/helper/internet_screen.dart';
import 'package:foodeoapp/screens/addproduct/viewmodel/addproduct_view_model.dart';

import 'package:foodeoapp/screens/addproduct/widget/allergence_bottom_sheet.dart';
import 'package:foodeoapp/screens/explorepage/widget/categoryCard.dart';
import 'package:foodeoapp/screens/profile/viewmodel/profile_view_model.dart';
import 'package:foodeoapp/screens/videos/model/add_video_model.dart';
import 'package:foodeoapp/screens/videos/model/serviceprovider_model.dart';
import 'package:foodeoapp/screens/videos/viewModel/video_viewmodel.dart';
import 'package:foodeoapp/screens/videos/widgets/serviceprovider_bottom_sheet.dart';
import 'package:foodeoapp/screens/videos/widgets/tags_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../constant/flutter_toast.dart';

class AddReelsScreen extends StatelessWidget {
  AddReelsScreen({super.key});

  @override
  final controller = Get.put(VideoViewModel());
  final controllerApi = Get.put(ProfileViewModel());
  final controllersProvider = Get.put(GetxControllersProvider());
  final internetController = Get.put(InternetController());

  final productnameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productpriceController = TextEditingController();
  final LinkController = TextEditingController();
  final domeController = TextEditingController();
  final NutritionalController = TextEditingController();
  final caloriesController = TextEditingController();

  FocusNode _namefocusNode = FocusNode();
  FocusNode _DescriptionFocusNode = FocusNode();
  FocusNode _PricefocusNode = FocusNode();
  FocusNode _NutritionFocusNode = FocusNode();
  FocusNode _linkfocusNode = FocusNode();

  RxBool hitApi = false.obs;
  final RxBool reelsError = false.obs;
  final _Firstformkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForwhite,
        child: Obx(
          () => internetController.isInternetConnected.isFalse
              ? NoInternetScreen(
                  onTap: () {
                    internetController.internetCheckerFun();
                  },
                )
              : Scaffold(
                  backgroundColor: themecontroller.bgcolor,
                  appBar: CustomAppBar(
                    margin: 0,
                    leading: () {
                      controller.SelectAllergensList.clear();
                      controller.SelectedtagsList.clear();
                      controller.compressing.value = false;
                      controller.videothembnail.value = '';
                      controller.videoContent.value = '';
                      controller.AllergensList.clear();
                      controller.tagsList.clear();
                      controller.ServiceProviderDataList.clear();
                      controller.NutrientList.clear();
                      Navigator.pop(context);
                    },
                    title: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: themecontroller.circlecolor.withOpacity(0.5)),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundImage: NetworkImage(
                                    'https://www.eatingwell.com/thmb/088YHsNmHkUQ7iNGP4375MiAXOY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/article_7866255_foods-you-should-eat-every-week-to-lose-weight_-04-d58e9c481bce4a29b47295baade4072d.jpg',
                                  ),
                                ),
                              ),
                              Text(
                                'Add Dish',
                                style: TextStyle(
                                    color: themecontroller.textcolor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.screenPadding),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _Firstformkey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.sp,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 15.sp, bottom: 10.sp),
                                child: Text(
                                  'Upload Reel',
                                  style: TextStyle(
                                      color: themecontroller.textcolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                            Obx(
                              () => SpringWidget(
                                onTap: () {
                                  controller.getVideoGallery();
                                },
                                child: Center(
                                    child: controller.videothembnail.value == ""
                                        ? Container(
                                            height: 170.sp,
                                            width: double.maxFinite,
                                            padding:
                                                controller.compressing.value
                                                    ? EdgeInsets.all(50.sp)
                                                    : EdgeInsets.all(70.sp),
                                            decoration: BoxDecoration(
                                                color:
                                                    themecontroller.colorwhite,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.sp)),
                                            child: controller.compressing.value
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SmallLoader(),
                                                      Text(
                                                        'uploading video ..',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 10.sp),
                                                      )
                                                    ],
                                                  )
                                                : SvgPicture.asset(
                                                    "assets/icons/upload.svg",
                                                    color: themecontroller
                                                        .textcolor
                                                        .withOpacity(0.4),
                                                    height: 20.sp,
                                                    width: 15.sp,
                                                  ),
                                          )
                                        : Container(
                                            height: 170.sp,
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                                color:
                                                    themecontroller.colorwhite,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.sp),
                                                image: DecorationImage(
                                                    image: FileImage(File(
                                                        controller
                                                            .videothembnail
                                                            .value)),
                                                    fit: BoxFit.cover)),
                                            // child: Image.file(
                                            //   File(controller.videothembnail.value),
                                            //   fit: BoxFit.fill,
                                            // ),
                                          )),
                              ),
                            ),
                            Obx(() => reelsError.value
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        'Please Upload Reels',
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 10.sp),
                                      ),
                                    ),
                                  )
                                : SizedBox()),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CustomTextFieldWidget(
                                focusNode: _namefocusNode,
                                fieldColor: themecontroller.colorwhite,
                                enabled: true,
                                controller: productnameController,
                                hintText: 'Product Name',
                                onsubmit: () {},
                                inputType: TextInputType.name,
                                validator: (input) => input!.length < 3
                                    ? 'entered text is too short'
                                    : input.length > 25
                                        ? 'entered text is too long the limit is: 25'
                                        : null,
                                label: 'Add a title'),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CustomTextFieldWidget(
                                focusNode: _DescriptionFocusNode,
                                fieldColor: themecontroller.colorwhite,
                                enabled: true,
                                controller: productDescriptionController,
                                hintText: 'Add description of product here',
                                onsubmit: () {},
                                inputType: TextInputType.name,
                                validator: (input) => input!.length < 3
                                    ? 'entered text is too short'
                                    : input.length > 1000
                                        ? 'entered text is too long the limit is: 1000'
                                        : null,
                                label: 'Add description'),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CustomTextFieldWidget(
                                focusNode: _PricefocusNode,
                                fieldColor: themecontroller.colorwhite,
                                enabled: true,
                                controller: productpriceController,
                                hintText: 'Product Price',
                                onsubmit: () {},
                                validator: (input) => input!.isEmpty
                                    ? 'enter Product Price ..'
                                    : input.length > 8
                                        ? 'entered text is too long the limit is: 8 digits'
                                        : null,
                                inputType: TextInputType.number,
                                label: 'Add Product Price'),
                            SizedBox(
                              height: 10.sp,
                            ),
                            // CustomTextFieldWidget(
                            //     focusNode: _linkfocusNode,
                            //     fieldColor: themecontroller.colorwhite,
                            //     enabled: true,
                            //     controller: LinkController,
                            //     hintText: 'Add Link',
                            //     onsubmit: () {},
                            //     validator: (input) =>
                            //         input!.isEmpty ? 'enter Please Enter Link..' : null,
                            //     inputType: TextInputType.number,
                            //     label: 'Add Link'),
                            // SizedBox(
                            //   height: 10.sp,
                            // ),
                            Obx(
                              () => controller.SelectAllergensList.isEmpty
                                  ? SpringWidget(
                                      onTap: () {
                                        AllergenceBottomSheet.show(context);
                                      },
                                      child: CustomTextFieldWidget(
                                          fieldColor:
                                              themecontroller.colorwhite,
                                          enabled: false,
                                          controller: domeController,
                                          hintText: 'Select Allergens',
                                          onsubmit: () {},
                                          inputType: TextInputType.name,
                                          label: 'Add Allergens'),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Allergens List',
                                              style: TextStyle(
                                                  color:
                                                      themecontroller.textcolor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12.sp),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.sp,
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  categorybtn(
                                                    // selected: true,
                                                    Colors: themecontroller
                                                        .colorPrimary,
                                                    textColors: themecontroller
                                                        .colorwhite,
                                                    image: '',
                                                    name: '  Clear  ',
                                                    onTap: () {
                                                      controller
                                                              .SelectAllergensList
                                                          .clear();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 1.sp,
                                                  ),
                                                  ...controller
                                                      .SelectAllergensList.map(
                                                    (e) => categorybtn(
                                                      // selected: false,
                                                      image: '',
                                                      name: e.allergens,
                                                      onTap: () {},
                                                    ),
                                                  ).toList()
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),

                            // Obx(() => SpringWidget(
                            //       onTap: () {
                            //         ServiceBottomSheet.show(context);
                            //       },
                            //       child: CustomTextFieldWidget(
                            //           fieldColor: themecontroller.colorwhite,
                            //           enabled: false,
                            //           controller: controller.AllergensController.value,
                            //           hintText: 'Select Service Provider',
                            //           onsubmit: () {},
                            //           // validator: (input) => input!.isEmpty
                            //           //     ? 'select Atleast one Allergens'
                            //           //     : null,
                            //           inputType: TextInputType.name,
                            //           label: 'Add Service Provider'),
                            //     )),

                            Obx(
                              () => Visibility(
                                visible: controller.SelectedtagsList.isNotEmpty,
                                replacement: SpringWidget(
                                  onTap: () {
                                    tagsBottomSheet.show(context);
                                  },
                                  child: CustomTextFieldWidget(
                                      fieldColor: themecontroller.colorwhite,
                                      enabled: false,
                                      controller: domeController,
                                      hintText: 'Select Tags',
                                      onsubmit: () {},
                                      // validator: (input) => input!.isEmpty
                                      //     ? 'select Atleast one Allergens'
                                      //     : null,
                                      inputType: TextInputType.name,
                                      label: 'Add Tags'),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Tags List',
                                          style: TextStyle(
                                              color: themecontroller.textcolor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.sp,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              categorybtn(
                                                // selected: true,
                                                Colors: themecontroller
                                                    .colorPrimary,
                                                textColors:
                                                    themecontroller.colorwhite,
                                                image: '',
                                                name: '  Clear  ',
                                                onTap: () {
                                                  controller.SelectedtagsList
                                                      .clear();
                                                },
                                              ),
                                              SizedBox(
                                                width: 1.sp,
                                              ),
                                              ...controller.SelectedtagsList
                                                  .map(
                                                (e) => categorybtn(
                                                  // selected: false,
                                                  image: '',
                                                  name: e.tags,
                                                  onTap: () {},
                                                ),
                                              ).toList()
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Obx(() => SpringWidget(
                                        onTap: () {
                                          ServiceBottomSheet.show(context);
                                        },
                                        child: CustomTextFieldWidget(
                                            fieldColor:
                                                themecontroller.colorwhite,
                                            enabled: false,
                                            controller: controller
                                                .serviceproviderController
                                                .value,
                                            hintText: 'Select Service Provider',
                                            onsubmit: () {},
                                            // validator: (input) => input!.isEmpty
                                            //     ? 'select Atleast one Allergens'
                                            //     : null,
                                            inputType: TextInputType.name,
                                            label: 'Add Provider'),
                                      )),
                                ),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CustomTextFieldWidget(
                                      focusNode: _linkfocusNode,
                                      fieldColor: themecontroller.colorwhite,
                                      enabled: true,
                                      controller: LinkController,
                                      hintText: 'Add Link',
                                      onsubmit: () {},
                                      // validator: (input) => input!.isEmpty
                                      //     ? 'enter Please Enter Link..'
                                      //     : null,
                                      inputType: TextInputType.name,
                                      label: ''),
                                ),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          height: 25.sp,
                                        ),
                                        SpringWidget(
                                          onTap: () {
                                            if (controller
                                                        .serviceproviderController
                                                        .value
                                                        .text !=
                                                    '' &&
                                                LinkController.text != '') {
                                              controller.addserviceProvider(
                                                  controller
                                                      .SelectedProvider.value,
                                                  controller
                                                      .serviceproviderController
                                                      .value
                                                      .text,
                                                  LinkController.text);
                                              controller
                                                  .SelectedProvider.value = 0;
                                              controller
                                                  .serviceproviderController
                                                  .value
                                                  .clear();
                                              LinkController.clear();
                                            } else {
                                              FlutterToastDisplay.getInstance
                                                  .showToast(
                                                      "Please Enter Data");
                                            }
                                          },
                                          child: Container(
                                            width: 50.sp,
                                            height: 50.sp,
                                            decoration: BoxDecoration(
                                              color:
                                                  themecontroller.circlecolor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                            Obx(
                              () => Visibility(
                                visible: controller
                                    .ServiceProviderDataList.isNotEmpty,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Text('Provider Name' as String),
                                      trailing: Text('Url' as String),
                                    ),
                                    Container(
                                      height: 200.sp,
                                      child: ListView.builder(
                                        itemCount: controller
                                            .ServiceProviderDataList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: ListTile(
                                              leading: Text(controller
                                                  .ServiceProviderDataList[
                                                      index]
                                                  .name as String),
                                              trailing: SizedBox(
                                                width: 100,
                                                child: Text(controller
                                                    .ServiceProviderDataList[
                                                        index]
                                                    .orderUrl as String),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: CustomTextFieldWidget(
                                      fieldColor: themecontroller.colorwhite,
                                      enabled: true,
                                      controller: NutritionalController,
                                      hintText: 'Nutrition name',
                                      onsubmit: () {},
                                      inputType: TextInputType.name,
                                      label: 'Nutritional Values',
                                    )),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: CustomTextFieldWidget(
                                      fieldColor: themecontroller.colorwhite,
                                      enabled: true,
                                      controller: caloriesController,
                                      hintText: 'calories',
                                      onsubmit: () {},
                                      inputType: TextInputType.number,
                                      label: '',
                                    )),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          height: 25.sp,
                                        ),
                                        SpringWidget(
                                          onTap: () {
                                            if (NutritionalController.text !=
                                                    '' &&
                                                caloriesController.text != '') {
                                              controller.addNutritions(
                                                  caloriesController.text,
                                                  NutritionalController.text);
                                              NutritionalController.clear();
                                              caloriesController.clear();
                                            } else {
                                              FlutterToastDisplay.getInstance
                                                  .showToast(
                                                      "Please Enter Data");
                                            }
                                          },
                                          child: Container(
                                            width: 50.sp,
                                            height: 50.sp,
                                            decoration: BoxDecoration(
                                              color:
                                                  themecontroller.circlecolor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                            Obx(
                              () => Visibility(
                                visible: controller.NutrientList.isNotEmpty,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Text('Nutrition Name' as String),
                                      trailing: Text('Calories' as String),
                                    ),
                                    Container(
                                      height: 200.sp,
                                      child: ListView.builder(
                                        itemCount:
                                            controller.NutrientList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            leading: Text(controller
                                                .NutrientList[index]
                                                .nutritional_names as String),
                                            trailing: Text(controller
                                                .NutrientList[index]
                                                .nutritional_values as String),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 20.sp,
                            ),
                            Obx(
                              () => SpringWidget(
                                onTap: () async {
                                  await internetController.internetCheckerFun();

                                  if (internetController
                                      .isInternetConnected.isTrue) {
                                    if (controllerApi.VideoContentList.length >
                                        3) {
                                      FlutterToastDisplay.getInstance.showToast(
                                          "You can Add only 3 reel for now");
                                    } else {
                                      if (controller
                                          .videothembnail.isNotEmpty) {
                                        reelsError.value = false;
                                        if (_Firstformkey.currentState!
                                            .validate()) {
                                          hitApi.value = true;
                                          AddVideoModel videoData = AddVideoModel(
                                              id: 0,
                                              title: productnameController.text,
                                              description:
                                                  productDescriptionController
                                                      .text,
                                              price:
                                                  productpriceController.text,
                                              thumbnail: controller
                                                  .videothembnail.value,
                                              content:
                                                  controller.videoContent.value,
                                              tagsList: controller.tagsList,
                                              allergensList:
                                                  controller.AllergensList,
                                              nutrientList:
                                                  controller.NutrientList,
                                              serverProviderId: controller
                                                  .SelectedProvider.value,
                                              ServiceProviderList: controller
                                                  .ServiceProviderDataList);

                                          var data = await controller
                                              .addVideo(videoData);
                                          hitApi.value = false;

                                          productnameController.text = '';
                                          productDescriptionController.text =
                                              '';
                                          productpriceController.text = '';
                                          controller.SelectAllergensList
                                              .clear();
                                          controller.SelectedtagsList.clear();
                                          controller.compressing.value = false;
                                          controller.videothembnail.value = '';
                                          controller.videoContent.value = '';
                                          controller.AllergensList.clear();
                                          controller.tagsList.clear();
                                          controller.ServiceProviderDataList
                                              .clear();
                                          controller.NutrientList.clear();
                                          await controllerApi
                                              .getrestaurantProfileData();
                                          _namefocusNode.unfocus();
                                          _DescriptionFocusNode.unfocus();
                                          _PricefocusNode.unfocus();
                                          hitApi.value = false;
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        reelsError.value = true;
                                      }
                                    }
                                  } else {
                                    FlutterToastDisplay.getInstance.showToast(
                                        "Please check your internet");
                                  }
                                },
                                child: RoundButton(
                                  margin: 0,
                                  loading: hitApi.value,
                                  disabled: hitApi.isFalse,
                                  gradient: true,
                                  height: 50,
                                  onTap: () {},
                                  title: 'Save',
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
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/screens/videos/viewModel/nutrients_view_model.dart';
import 'package:get/get.dart';
import '../../../components/circle_withtext.dart';
import '../model/nutrients_model.dart';

class NutrientBottomSheet extends StatefulWidget {
  final int productId;
  NutrientBottomSheet({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<NutrientBottomSheet> createState() => _NutrientBottomSheetState();
}

class _NutrientBottomSheetState extends State<NutrientBottomSheet> {
  final controller = Get.put(NutrientsViewModel());

  RxBool isDarkTheme = false.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getPrdouctNutrients(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: const Color(0xfff2f4f7),
          systemNavigationBarColor: themecontroller.colorwhite,
          statusBarBrightness:
              isDarkTheme.value ? Brightness.dark : Brightness.light,
          statusBarIconBrightness:
              isDarkTheme.value ? Brightness.light : Brightness.dark,
          systemNavigationBarIconBrightness:
              isDarkTheme.value ? Brightness.dark : Brightness.light,
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: themecontroller.bottomsheetGradient,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.only(
              left: Constants.screenPadding,
              right: Constants.screenPadding,
              top: 12.sp),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 15.sp,
                      ),
                      Text(
                        "Nutrients",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: themecontroller.textcolor,
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.close,
                            color: themecontroller.disablecolor,
                          ),
                        ),
                      )
                      // TextButton(
                      //     onPressed: () {
                      //       // AddAddress.show(context);
                      //     },
                      //     child: )
                    ],
                  ),
                ),
                Text(
                  'Allergens',
                  style: TextStyle(
                      color: themecontroller.textcolor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 80.sp,
                  child: Obx(
                    () => controller.isLoading.value
                        ? const Center(
                            child: SmallLoader(),
                          )
                        : controller.allergensList.isEmpty
                            ? Center(
                                child: Text(
                                  "No Allergens yet..",
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: themecontroller.textcolor
                                          .withOpacity(0.5)),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.allergensList.length,
                                itemBuilder: (context, index) {
                                  Allergens item =
                                      controller.allergensList[index];
                                  return CircleWithChild(
                                    // assets: true,
                                    url: item.image,
                                    title: item.allergens,
                                    titlecolor: themecontroller.circleicon,
                                  );
                                }),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Nutrients Value',
                  style: TextStyle(
                      color: themecontroller.textcolor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Expanded(
                    child: Obx(
                  () => controller.isLoading.value
                      ? const Center(child: SmallLoader())
                      : controller.nutrientsList.isEmpty
                          ? Center(
                              child: Text(
                                'No Nutrines yet..',
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: themecontroller.textcolor
                                        .withOpacity(0.5)),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.nutrientsList.length,
                              itemBuilder: (context, index) {
                                Nutrients item =
                                    controller.nutrientsList[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${item.nutritional_names} :',
                                            style: TextStyle(
                                                color:
                                                    themecontroller.textcolor,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            item.nutritional_values,
                                            style: TextStyle(
                                                color:
                                                    themecontroller.textcolor,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: themecontroller.disablecolor
                                          .withOpacity(0.3),
                                    )
                                  ],
                                );
                              }),
                ))
              ],
            ),
          ),
        ),
      );
    });
  }
}

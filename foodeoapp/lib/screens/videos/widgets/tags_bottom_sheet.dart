import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/screens/videos/viewModel/video_viewmodel.dart';
import 'package:get/get.dart';

class tagsBottomSheet extends StatelessWidget {
  tagsBottomSheet({
    Key? key,
  }) : super(key: key);
  @override
  final controller = Get.put(VideoViewModel());
  static Future show(BuildContext context) {
    final themecontroller = Get.put(ThemeHelper());

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: themecontroller.bgcolor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      builder: (context) {
        return tagsBottomSheet();
      },
    );
  }

  Widget build(BuildContext context) {
    controller.gettags();
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForwhite,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
              // gradient: themecontroller.containerGradient,
              color: themecontroller.colorwhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 6,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Constants.screenPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextButton(
                        onPressed: null,
                        child: SizedBox(),
                      ),
                      Text(
                        "Select tags",
                        style: TextStyle(
                          fontSize: 14,
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
                            padding: const EdgeInsets.only(right: 30),
                            child: Icon(
                              Icons.close,
                              color: themecontroller.disablecolor,
                            ),
                          ))
                    ],
                  ),
                  SizedBox(height: 10.sp),
                  Obx(
                    () => controller.Isloading.value
                        ? Center(
                            child: SmallLoader(),
                          )
                        : controller.tagsList.isEmpty
                            ? Center(
                                child: Text(
                                  'No tags Added yet..',
                                  style: TextStyle(
                                    color: themecontroller.textcolor,
                                  ),
                                ),
                              )
                            : Column(
                                children: controller.tagsList
                                    .map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Obx(
                                          () => SpringWidget(
                                            onTap: () {
                                              if (controller.SelectedtagsList
                                                  .contains(e)) {
                                                controller.SelectedtagsList
                                                    .remove(e);
                                              } else {
                                                controller.SelectedtagsList.add(
                                                    e);
                                              }
                                            },
                                            child: ListTile(
                                              // leading: CircleWithChild(
                                              //   assets: false,
                                              //   url: e.image,
                                              //   title: '',
                                              //   titlecolor: themecontroller.circleicon,
                                              // ),
                                              trailing:
                                                  controller.SelectedtagsList
                                                          .contains(e)
                                                      ? Icon(
                                                          Icons.check,
                                                          color: themecontroller
                                                              .colorIcon,
                                                        )
                                                      : SizedBox(),
                                              title: Text(
                                                e.tags,
                                                style: TextStyle(
                                                    color: themecontroller
                                                        .circleicon,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../components/small_loader.dart';
import '../../../components/spring_widget.dart';
import '../../../constant/flutter_toast.dart';
import '../../../constant/mybehavior.dart';
import '../../../constant/theme.dart';
import '../../../helper/internet_controller.dart';
import '../viewModel/comment_view_model.dart';
import 'comment_card.dart';

class CommentBottomSheet extends StatefulWidget {
  final int productId;

  CommentBottomSheet({
    super.key,
    required this.productId,
  });

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final controller = Get.put(CommentViewModel());
  final internetController = Get.put(InternetController());
  bool apihitting = false;
  RxBool isDarkTheme = false.obs;
  @override
  void initState() {
    super.initState();
    controller.getPrdouctComment(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
      builder: (themeController) => AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: const Color(0xfff2f4f7),
          systemNavigationBarColor: themeController.colorwhite,
          statusBarBrightness:
              isDarkTheme.value ? Brightness.dark : Brightness.light,
          statusBarIconBrightness:
              isDarkTheme.value ? Brightness.light : Brightness.dark,
          systemNavigationBarIconBrightness:
              isDarkTheme.value ? Brightness.dark : Brightness.light,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Container(
            color: themeController.backgoundcolor,
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Comments",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: themeController.textcolor,
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: controller.isloading.value
                          ? const SmallLoader()
                          : controller.commentList.isEmpty
                              ? Center(
                                  child: Text(
                                    'No Comment Added yet..',
                                    style: TextStyle(
                                      color: themeController.textcolor,
                                    ),
                                  ),
                                )
                              : ScrollConfiguration(
                                  behavior: MyBehavior(),
                                  child: ListView.builder(
                                    itemCount: controller.commentList.length,
                                    itemBuilder: (context, index) {
                                      print(controller
                                          .commentList[index].timeAgo);
                                      return CommentCard(
                                        userProfileImage:
                                            controller.commentList[index].image,
                                        userName:
                                            controller.commentList[index].name,
                                        comment: controller
                                            .commentList[index].comment,
                                        time: controller
                                            .commentList[index].timeAgo
                                            .toString(),
                                      );
                                    },
                                  ),
                                ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: themeController.cardcolor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  cursorColor: themeController.textcolor,
                                  onChanged: (value) {
                                    apihitting = true;
                                  },
                                  focusNode: controller.commentFocusNode,
                                  controller:
                                      controller.commentController.value,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: themeController.textcolor,
                                  ),
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Type Comment here...",
                                    hintStyle: TextStyle(
                                      color: themeController.textcolor,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              SpringWidget(
                                onTap: () async {
                                  controller.emojiShowing.value =
                                      !controller.emojiShowing.value;
                                  controller.commentFocusNode.unfocus();
                                  controller.commentFocusNode.canRequestFocus =
                                      true;
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '😊',
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                ),
                              ),
                              // FloatingActionButton.small(
                              //   onPressed: () {},
                              //   elevation: 0,

                              //   backgroundColor: Colors.yellow,
                              //   // backgroundColor: themeController.colorPrimary,
                              //   child: SvgPicture.asset(
                              //     "assets/icons/gift_outlined.svg",
                              //     color: Colors.white,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      FloatingActionButton.small(
                        onPressed: () {
                          internetController.internetCheckerFun();

                          print(controller.commentController.value.text);

                          if (controller.commentController.value.text != '' &&
                              controller.commentController.value.text != null) {
                            if (internetController.isInternetConnected.value ==
                                true) {
                              controller.postPrdouctComment(widget.productId,
                                  controller.commentController.value.text);
                              apihitting = false;
                            } else {
                              FlutterToastDisplay.getInstance
                                  .showToast("Please check your internet");
                            }
                          } else {
                            if (apihitting == false) {
                              FlutterToastDisplay.getInstance
                                  .showToast("Please enter a comments");
                            }
                          }
                        },
                        elevation: 0,
                        backgroundColor: themeController.colorPrimary,
                        child: SvgPicture.asset(
                          "assets/icons/send.svg",
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => Offstage(
                      offstage: !controller.emojiShowing.value,
                      child: SizedBox(
                        height: 250.sp,
                        child: EmojiPicker(
                          onEmojiSelected: (category, emoji) {
                            controller.commentController.value.text =
                                controller.commentController.value.text +
                                    emoji.emoji;
                          },
                          onBackspacePressed: () {},
                          config: Config(
                              columns: 7,
                              verticalSpacing: 0,
                              horizontalSpacing: 0,
                              initCategory: Category.SMILEYS,
                              bgColor: Color(0xFFF2F2F2),
                              indicatorColor: themeController.colorPrimary,
                              iconColor:
                                  themeController.colorPrimary.withOpacity(0.4),
                              iconColorSelected: themeController.colorPrimary,
                              noRecents: Text(
                                'No Recents',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: themeController.colorPrimary
                                      .withOpacity(0.5),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              recentsLimit: 28,
                              tabIndicatorAnimDuration: kTabScrollDuration,
                              categoryIcons: CategoryIcons(),
                              buttonMode: ButtonMode.MATERIAL),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

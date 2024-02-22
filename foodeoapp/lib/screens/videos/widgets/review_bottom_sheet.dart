import 'package:flutter/material.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/screens/videos/viewModel/review_view_model.dart';
import 'package:get/get.dart';
import 'review_card.dart';

class RviewBottomSheet extends StatelessWidget {
  final int productId;
  RviewBottomSheet({
    Key? key, required this.productId,
  }) : super(key: key);
  @override
  final ReviewController = Get.put(ReviewViewModel());
  static Future show(BuildContext context, int productId) {
    final themecontroller = Get.put(ThemeHelper());
    
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: themecontroller.bgcolor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      builder: (context) {
        return RviewBottomSheet(productId: productId,);
      },
    );
  }

  
  Widget build(BuildContext context) {
    ReviewController.getProductReviews(productId);
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForwhite,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                    Text(
                      "Reviews",
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
                const SizedBox(height: 10),
                Expanded(
                  child: Obx(
                    () => ReviewController.Isloading.value
                        ? Center(
                            child: SmallLoader(),
                          )
                        : ReviewController.reviewsList.isEmpty
                            ? Center(
                                child: Text(
                                  'No Review Added yet..',
                                  style: TextStyle(
                                    color: themecontroller.textcolor,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: ReviewController.reviewsList.length,
                                itemBuilder: (context, index) {
                                  return ReviewCard(
                                      userProfileImage: ReviewController
                                          .reviewsList[index].userPicture,
                                      userName: ReviewController
                                          .reviewsList[index].username,
                                      rating: ReviewController
                                          .reviewsList[index].rating,
                                      comment: ReviewController
                                          .reviewsList[index].comment);
                                },
                              ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

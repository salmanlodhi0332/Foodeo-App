import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/screens/Addons/view/addons_screen.dart';
import 'package:foodeoapp/screens/addproduct/viewmodel/addproduct_view_model.dart';
import 'package:foodeoapp/screens/videos/widgets/review_bottom_sheet.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;
  // final int reelId;
  ProductDetailScreen({
    super.key,
    required this.productId,
    // required this.reelId,
  });

  @override
  final productController = AddProductViewModel();
  Widget build(BuildContext context) {
    productController.getproductData(productId);
    return GetBuilder<ThemeHelper>(
      builder: (themeController) => AnnotatedRegion(
        value: themeController.systemUiOverlayStyleForwhite,
        child: Scaffold(
          body: SafeArea(
            child: Obx(
              () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: productController.Isloading.value
                    ? const Center(child: SmallLoader())
                    : productController.producrtData.isEmpty
                        ? Center(
                            child: Text(
                              'Product not loaded',
                              style: TextStyle(
                                color: themeController.colorwhite,
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  child: ImageWidget(
                                      imageUrl: productController
                                          .producrtData.first.productImage,
                                      width: double.maxFinite),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Constants.screenPadding),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20.sp),
                                      Text(
                                        productController
                                            .producrtData.first.productName,
                                        style: TextStyle(
                                            color: themeController.textcolor,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 5.sp),
                                      Text(
                                        '\$ ${productController.producrtData.first.productPrice}',
                                        style: TextStyle(
                                            color: themeController.colorPrimary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp),
                                      ),
                                      SizedBox(height: 20.sp),
                                      Text(
                                        productController
                                            .producrtData.first.productDetails,
                                        softWrap: true,
                                        maxLines: 6,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: themeController.textcolor
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                      SizedBox(height: 20.sp),
                                      ListTile(
                                        onTap: () {
                                          RviewBottomSheet.show(context, 1);
                                        },
                                        leading: SvgPicture.asset(
                                          "assets/icons/star.svg",
                                          height: 25.sp,
                                          color: const Color.fromARGB(
                                              255, 251, 208, 77),
                                        ),
                                        title: Row(
                                          children: [
                                            Text(
                                              productController.producrtData
                                                  .first.ratingsAverage
                                                  .toString(),
                                              style: TextStyle(
                                                  color:
                                                      themeController.textcolor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              '(${productController.producrtData.first.reviewsCount.toString()} reviews)',
                                              style: TextStyle(
                                                color:
                                                    themeController.textcolor,
                                                fontSize: 14.sp,
                                              ),
                                            )
                                          ],
                                        ),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
              ),
            ),
          ),
          bottomNavigationBar: Obx(
            () => productController.Isloading.value
                ? SizedBox()
                : Visibility(
                    visible: DataStroge.userToken != '',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.screenPadding,
                          vertical: Constants.screenPadding),
                      child: RoundButton(
                        margin: 0,
                        gradient: true,
                        height: 50,
                        onTap: () {
                          Navigation.getInstance.screenNavigation(
                              context,
                              addonsScreen(
                                productId: productId,
                              ));
                        },
                        title: 'continue',
                        iconColor: themeController.colorwhite,
                        textColor: themeController.colorwhite,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

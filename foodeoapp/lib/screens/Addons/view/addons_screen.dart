import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/circle_withtext.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/screens/Addons/addons_ViewModel.dart';
import 'package:foodeoapp/screens/ordersummary/view/order_summary_screen.dart';
import 'package:get/get.dart';

class addonsScreen extends StatelessWidget {
  final int productId;

  addonsScreen({
    super.key,
    required this.productId,
  });
  final addonsController = Get.put(AddonsViewModel());

  @override
  Widget build(BuildContext context) {
    addonsController.getAddonsByProductId(productId);
    return GetBuilder<ThemeHelper>(
      builder: (themeController) => AnnotatedRegion(
        value: themeController.systemUiOverlayStyleForwhite,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: themeController.bgcolor,
            body: GetBuilder<AddonsViewModel>(
              init: AddonsViewModel(),
              builder: (addonsController) => Container(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Constants.screenPadding),
                            child: CustomAppBar(
                                appbarpadding: false,
                                margin: 20,
                                leading: () {
                                  Navigator.pop(context);
                                },
                                title: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      gradient:
                                          themeController.containerGradient),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundImage: NetworkImage(
                                                'https://www.eatingwell.com/thmb/088YHsNmHkUQ7iNGP4375MiAXOY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/article_7866255_foods-you-should-eat-every-week-to-lose-weight_-04-d58e9c481bce4a29b47295baade4072d.jpg',
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Add Add ons',
                                            style: TextStyle(
                                                color:
                                                    themeController.textcolor,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ]),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 34.sp,
                          ),
                          Stack(children: [
                            Image.asset(
                              'assets/icons/temp.png',
                              // height: 300,
                            ),
                            Obx(
                              () => Positioned(
                                bottom: 0,
                                right: 80.sp,
                                child: AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastOutSlowIn,
                                  transform: Matrix4.translationValues(0,
                                      addonsController.slideDistance.value, 0),
                                  child: Transform(
                                    transform: Matrix4.translationValues(
                                        0,
                                        addonsController.slideDistance.value,
                                        0),
                                    child: Image.asset(
                                      'assets/icons/dish.png',
                                      // height: 300,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: themeController.containerGradient,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: SafeArea(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: Constants.screenPadding,
                              ),
                              Text(
                                "Dish customization",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  letterSpacing: 1,
                                  wordSpacing: 5,
                                  fontWeight: FontWeight.w700,
                                  color: themeController.textcolor,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Tap to add to your dish",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w100,
                                  color: themeController.textcolor,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Constants.screenPadding),
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 5.0,
                                      childAspectRatio: 0.8,
                                    ),
                                    itemCount:
                                        addonsController.AddonsList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final addon =
                                          addonsController.AddonsList[index];

                                      return Obx(
                                        () => GestureDetector(
                                          onTap: () {
                                            final addon = addonsController
                                                .AddonsList[index];
                                            addonsController.isSelected.value =
                                                addonsController.selectedAddons
                                                    .contains(addon);

                                            print(addonsController
                                                .isSelected.value);

                                            if (addonsController
                                                .isSelected.value) {
                                              addonsController.selectedAddons
                                                  .remove(addon);

                                              addonsController.AddAddons(
                                                  productId, addon.id, 0);

                                              addon.selected.value = true;
                                              print(addonsController
                                                  .selectedAddons.length);
                                              addon.selected.value = false;
                                            } else {
                                              addonsController.selectedAddons
                                                  .add(addon);
                                              print(addonsController
                                                  .selectedAddons.length);

                                              addonsController.AddAddons(
                                                  productId, addon.id, 1);
                                              addon.selected.value = true;
                                              // total.value = total+  addon.price;
                                            }
                                          },
                                          child: CircleWithChild(
                                            radius: 28.sp,
                                            isSelected: addon.selected.value,
                                            url: addon.picture,
                                            title: addon.name,
                                            price: addon.price.toString(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Obx(
                                () => Padding(
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
                                          OrderSummaryScreen(
                                            productId: 2,
                                          ));
                                    },
                                    title:
                                        'Add to cart (${Constants.currency} ${addonsController.total.value})',
                                    iconColor: themeController.colorwhite,
                                    textColor: themeController.colorwhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

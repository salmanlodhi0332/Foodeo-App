import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../components/custom_appbar.dart';
import '../../../../constant/mybehavior.dart';
import '../../../../constant/theme.dart';

import '../widget/past_order_tab.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
          value: themecontroller.systemUiOverlayStyleForwhite,
          child: Scaffold(
              backgroundColor: themecontroller.bgcolor,
              appBar: CustomAppBar(
                appbarpadding: false,
                leadingmargin: Constants.screenPadding,
                leading: () {
                  Navigator.pop(context);
                },
                title: Text(
                  "My Order",
                  style: TextStyle(
                      color: themecontroller.textcolor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp),
                ),
                margin: 0,
              ),
              body: SafeArea(
                  child: DefaultTabController(
                      length: 2,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Constants.screenPadding),
                              child: TabBar(
                                splashFactory: NoSplash.splashFactory,
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  return states.contains(MaterialState.focused)
                                      ? null
                                      : Colors.transparent;
                                }),
                                labelColor: themecontroller.colorPrimary,
                                indicatorColor: themecontroller.colorPrimary,
                                labelPadding: const EdgeInsets.all(4.0),
                                unselectedLabelColor: Colors.grey[400],
                                tabs: const [
                                  Tab(text: 'Past Order'),
                                  Tab(text: 'Active Order'),
                                ],
                              ),
                            ),
                            Expanded(
                                child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: TabBarView(children: [
                                PastOrderTab(),
                                // UserOrderScreen(),
                              ]),
                            ))
                          ])))));
    });
  }
}

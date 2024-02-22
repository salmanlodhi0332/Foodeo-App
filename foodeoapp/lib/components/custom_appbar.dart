import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';
import '../constant/constants.dart';
import 'spring_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? leading;
  final Widget? title;
  final EdgeInsetsGeometry? padding;
  final Widget? trailing;
  final bool hideDivider;
  final double height;
  final double? margin;
  final Color? backgroundColor;
  final Color? leadingColor;
  final double leadingmargin;
  final bool appbarpadding;

  CustomAppBar({
    Key? key,
    this.leading,
    this.leadingmargin = 0,
    this.margin = 10,
    this.title,
    this.trailing,
    this.padding,
    this.hideDivider = false,
    this.height = 60,
    this.backgroundColor,
    this.leadingColor,
    this.appbarpadding = true,
  }) : super(key: key);

  final themecontroller = Get.put(ThemeHelper());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeHelper());
    return Padding(
      padding: appbarpadding
          ? EdgeInsets.symmetric(horizontal: Constants.screenPadding)
          : EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: backgroundColor,
        child: Column(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: margin!),
            color: backgroundColor,
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leading != null)
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Platform.isIOS
                          ? SpringWidget(
                              onTap: leading!,
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color:
                                    leadingColor ?? themecontroller.colorIcon,
                              ),
                            )
                          : GestureDetector(
                              onTap: leading,
                              child: Container(
                                margin: EdgeInsets.only(left: leadingmargin),
                                decoration: BoxDecoration(
                                    color: themeController.colorwhite,
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: themeController.textcolor,
                                  ),
                                ),
                              ),
                            )),
                if (leading == null) const SizedBox(),
                if (title != null)
                  Align(alignment: Alignment.center, child: title),
                if (title == null) const SizedBox(),
                if (trailing != null)
                  Align(alignment: Alignment.centerRight, child: trailing!),
                if (trailing == null)
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.screenPadding,
                    ),
                  )
              ],
            ),
            // if (!hideDivider) const Divider(height: 0),
          ),
        ])
        
    )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

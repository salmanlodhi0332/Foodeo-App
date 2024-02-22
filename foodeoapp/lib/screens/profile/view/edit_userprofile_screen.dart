import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';
import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/data/model/user_model.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/helper/getx_helper.dart';
import 'package:foodeoapp/screens/profile/viewmodel/profile_view_model.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EditUserProfileScreen extends StatelessWidget {
  EditUserProfileScreen({super.key});

  final nameController = TextEditingController();
  final PhoneController = TextEditingController();
  final EmailController = TextEditingController();
  RxBool hitApi = false.obs;
  FocusNode _namefocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _PhonefocusNode = FocusNode();
  final controllerApi = Get.put(ProfileViewModel());
  final controllersProvider = Get.put(GetxControllersProvider());
  final _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    nameController.text = DataStroge.userName.value;
    EmailController.text = DataStroge.userEmail.value;
    PhoneController.text =
        DataStroge.userPhone.value == 'null' ? '' : DataStroge.userPhone.value;
    // DescriptionController.text = DataStroge..value;
    nameController.text = DataStroge.userName.value;
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForwhite,
        child: Scaffold(
          backgroundColor: themecontroller.bgcolor,
          appBar: CustomAppBar(
              leading: () {
                Navigator.pop(context);
              },
              margin: 0,
              title: Text(
                'Edit Profile',
                style: TextStyle(
                    color: themecontroller.textcolor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
              )),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Constants.screenPadding),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Obx(
                      () => SpringWidget(
                        onTap: () {
                          controllersProvider.getImage();
                        },
                        child: Center(
                          child: controllersProvider.imagePath.value.isNotEmpty
                              ? Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(30),
                                    child: CircleAvatar(
                                      radius: 50.sp,
                                      backgroundImage: FileImage(
                                        File(controllersProvider
                                            .imagePath.value),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30.sp,
                                    top: 60.sp,
                                    height: 120.sp,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          themecontroller.colorPrimary,
                                      child: Icon(
                                        Icons.edit,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ),
                                    ),
                                  )
                                ])
                              : DataStroge.userImage.value == "null"
                                  ? Stack(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(30),
                                        child: CircleAvatar(
                                            radius: 50.sp,
                                            backgroundImage: AssetImage(
                                                controllersProvider
                                                    .defaultImagePath
                                                    .toString())),
                                      ),
                                      Positioned(
                                        right: 30.sp,
                                        top: 60.sp,
                                        height: 120.sp,
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              themecontroller.colorPrimary,
                                          child: Icon(
                                            Icons.edit,
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                          ),
                                        ),
                                      )
                                    ])
                                  : Stack(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(30),
                                        child: CircleAvatar(
                                            radius: 50.sp,
                                            backgroundImage: NetworkImage(
                                                DataStroge.userImage.value ??
                                                    '')),
                                      ),
                                      Positioned(
                                        right: 30.sp,
                                        top: 60.sp,
                                        height: 120.sp,
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              themecontroller.colorPrimary,
                                          child: Icon(
                                            Icons.edit,
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                          ),
                                        ),
                                      )
                                    ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    CustomTextFieldWidget(
                      focusNode: _namefocusNode,
                      fieldColor: themecontroller.colorwhite,
                      enabled: true,
                      controller: nameController,
                      hintText: 'Enter name',
                      onsubmit: () {},
                      inputType: TextInputType.name,
                      label: 'Name',
                      validator: (input) => input!.length < 3
                          ? 'entered text is too short'
                          : input.length > 25
                              ? 'entered text is too long the limit is: 25'
                              : null,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    CustomTextFieldWidget(
                      focusNode: _emailFocusNode,
                      fieldColor: themecontroller.colorwhite,
                      enabled:
                          DataStroge.userEmail.value == 'null' ? true : false,
                      controller: EmailController,
                      hintText: 'Enter your Email Address',
                      onsubmit: () {},
                      inputType: TextInputType.emailAddress,
                      label: 'Email Address',
                      validator: (input) {
                        if (input!.isEmpty) {
                          return "Please enter your email".tr;
                        } else if (!input.contains('@')) {
                          return "invalid email".tr;
                        } else if (!controllersProvider.isValidEmail(input)) {
                          return "invalid email format".tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    CustomTextFieldWidget(
                      focusNode: _PhonefocusNode,
                      fieldColor: themecontroller.colorwhite,
                      enabled:
                          DataStroge.userPhone.value == 'null' ? true : false,
                      controller: PhoneController,
                      hintText: 'Enter your Phone Number',
                      onsubmit: () {},
                      inputType: TextInputType.phone,
                      label: 'Phone Number',
                      validator: (input) => input!.isEmpty
                          ? 'Please enter your Phone number'
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 80.sp,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.screenPadding,
                  vertical: Constants.screenPadding),
              child: SpringWidget(
                onTap: () async {
                  if (_formkey.currentState!.validate()) {
                    hitApi.value = true;
                    UserModel userData = UserModel(
                        image: controllersProvider.imagePath.value,
                        name: nameController.text,
                        email: EmailController.text,
                        phoneNumber: PhoneController.text);
                    UserModel updateUser =
                        await controllerApi.editUserProfile(userData);

                    var _pref = DataStroge();

                    print(userData.image);
                    _pref.updateUserData(
                        Phone: userData.phoneNumber,
                        email: userData.email,
                        name: userData.name,
                        photo: updateUser.image);

                    hitApi.value = false;
                    Navigator.pop(context);
                    controllersProvider.imagePath.value = '';
                    _namefocusNode.unfocus();
                    _emailFocusNode.unfocus();
                    _PhonefocusNode.unfocus();
                  } else {
                    // controller.loading.value;
                    // functionHit = false;
                  }
                },
                child: Obx(
                  () => RoundButton(
                    margin: 0,
                    loading: hitApi.value,
                    disabled: hitApi.isFalse,
                    gradient: true,
                    height: 50.sp,
                    onTap: () {
                      // if (_formkey.currentState!.validate()) {
                      //   UserModel userData = UserModel(
                      //       name: nameController.text,
                      //       email: EmailController.text,
                      //       phoneNumber: PhoneController.text);
                      //   controllerApi.editUserProfile(userData);

                      //   controllersProvider.imagePath.value = '';
                      //   _namefocusNode.unfocus();
                      //   _emailFocusNode.unfocus();
                      //   _PhonefocusNode.unfocus();
                      // } else {
                      //   // controller.loading.value;
                      //   // functionHit = false;
                      // }
                    },
                    title: 'Save',
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

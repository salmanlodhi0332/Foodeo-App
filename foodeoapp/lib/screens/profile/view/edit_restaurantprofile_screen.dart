import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';
import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/helper/getx_helper.dart';
import 'package:foodeoapp/helper/internet_controller.dart';
import 'package:foodeoapp/helper/internet_screen.dart';
import 'package:foodeoapp/screens/profile/model/restaurant_model.dart';
import 'package:foodeoapp/screens/profile/viewmodel/profile_view_model.dart';
import 'package:foodeoapp/screens/videos/model/openinnghour_model.dart';
import 'package:foodeoapp/screens/videos/viewModel/video_viewmodel.dart';
import 'package:get/get.dart';

import '../../../constant/flutter_toast.dart';

class EditRestaurantProfileScreen extends StatelessWidget {
  EditRestaurantProfileScreen({super.key});

  @override
  final controllersProvider = Get.put(GetxControllersProvider());
  final controllersApi = Get.put(ProfileViewModel());
  final internetController = Get.put(InternetController());
  RxBool hitApi = false.obs;

  final _formkey = GlobalKey<FormState>();
  FocusNode _namefocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _DescriptionFocusNode = FocusNode();
  FocusNode _PhonefocusNode = FocusNode();
  FocusNode _orderlengthfocusNode = FocusNode();

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
                  backgroundColor: themecontroller.backgoundcolor,
                  appBar: CustomAppBar(
                      leading: () {
                        controllersApi.OpeningHoursList.clear();
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.screenPadding),
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
                                  child: controllersProvider
                                          .imagePath.value.isNotEmpty
                                      ? Stack(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(30),
                                            child: CircleAvatar(
                                              radius: 60.sp,
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
                                      : DataStroge.userImage.value == ""
                                          ? Stack(children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(30),
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
                                                      themecontroller
                                                          .colorPrimary,
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
                                                padding:
                                                    const EdgeInsets.all(30),
                                                child: CircleAvatar(
                                                    radius: 50.sp,
                                                    backgroundImage:
                                                        NetworkImage(DataStroge
                                                                .userImage
                                                                .value ??
                                                            '')),
                                              ),
                                              Positioned(
                                                right: 30.sp,
                                                top: 60.sp,
                                                height: 120.sp,
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      themecontroller
                                                          .colorPrimary,
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
                                fieldColor: themecontroller.cardcolor,
                                enabled: true,
                                controller: controllersApi.nameController,
                                hintText: 'Enter name',
                                onsubmit: () {},
                                inputType: TextInputType.name,
                                validator: (input) => input!.length < 3
                                    ? 'entered text is too short'
                                    : input.length > 25
                                        ? 'entered text is too long the limit is: 25'
                                        : null,
                                label: 'Creator Name'),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CustomTextFieldWidget(
                                focusNode: _DescriptionFocusNode,
                                fieldColor: themecontroller.cardcolor,
                                enabled: true,
                                controller:
                                    controllersApi.DescriptionController,
                                hintText:
                                    'Type Your Restaurant Description here...',
                                validator: (input) => input!.length < 3
                                    ? 'entered text is too short'
                                    : input.length > 1000
                                        ? 'entered text is too long the limit is: 1000'
                                        : null,
                                onsubmit: () {},
                                inputType: TextInputType.multiline,
                                label: 'Restaurant Description'),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CustomTextFieldWidget(
                              focusNode: _PhonefocusNode,
                              fieldColor: themecontroller.cardcolor,
                              enabled: DataStroge.userPhone.value == 'null'
                                  ? true
                                  : false,
                              controller: controllersApi.PhoneController,
                              hintText: 'Enter your Phone Number',
                              onsubmit: () {},
                              validator: (input) => input!.isEmpty
                                  ? 'Please Enter your phone number'
                                  : null,
                              inputType: TextInputType.number,
                              label: 'Phone Number',
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CustomTextFieldWidget(
                              focusNode: _emailFocusNode,
                              fieldColor: themecontroller.cardcolor,
                              enabled: DataStroge.userPhone.value == 'null'
                                  ? true
                                  : false,
                              controller: controllersApi.EmailController,
                              hintText: 'Enter your Email Address',
                              onsubmit: () {},
                              inputType: TextInputType.emailAddress,
                              label: 'Email Address',
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return "Please enter your email".tr;
                                } else if (!input.contains('@')) {
                                  return "invalid email".tr;
                                } else if (!controllersProvider
                                    .isValidEmail(input)) {
                                  return "invalid email format".tr;
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CustomTextFieldWidget(
                              fieldColor: themecontroller.cardcolor,
                              enabled: true,
                              controller: controllersApi.orderlengthController,
                              hintText: 'Enter your minimum order amount',
                              onsubmit: () {},
                              inputType: TextInputType.number,
                              label: 'Minimum Order Amount',
                              validator: (input) => input!.isEmpty
                                  ? 'Please Enter your minimum order amount'
                                  : input.length > 7
                                      ? 'entered text is too long the limit is: 7'
                                      : null,
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CustomTextFieldWidget(
                              fieldColor: themecontroller.cardcolor,
                              enabled: true,
                              controller:
                                  controllersApi.DeliveryChargesController,
                              hintText: 'Enter delivery charges',
                              onsubmit: () {},
                              inputType: TextInputType.number,
                              label: 'Delivery charges',
                              validator: (input) => input!.isEmpty
                                  ? 'Please Enter your delivery charges'
                                  : input.length > 7
                                      ? 'entered text is too long the limit is: 7'
                                      : null,
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Opening Hours',
                                    style: TextStyle(
                                        color: themecontroller.textcolor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.sp),
                                  ),
                                  Obx(
                                    () => SpringWidget(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return MyDialog();
                                          },
                                        );
                                      },
                                      child: controllersApi
                                              .OpeningHoursList.isEmpty
                                          ? Text(
                                              'add',
                                              style: TextStyle(
                                                  color: themecontroller
                                                      .colorPrimary,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12.sp),
                                            )
                                          : Text(
                                              'Edit',
                                              style: TextStyle(
                                                  color: themecontroller
                                                      .colorPrimary,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12.sp),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => Container(
                                width: double.infinity,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: themecontroller.cardcolor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: controllersApi
                                          .OpeningHoursList.isEmpty
                                      ? [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 50,
                                            ),
                                            child: Text(
                                              'No Time Slote Added',
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: themecontroller
                                                      .disablecolor),
                                            ),
                                          )
                                        ]
                                      : controllersApi.OpeningHoursList.map(
                                          (e) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${e.selectedDay}',
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: themecontroller
                                                          .disablecolor),
                                                ),
                                                Text(
                                                  '${e.startTime} - ${e.endTime}',
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: themecontroller
                                                          .disablecolor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.screenPadding,
                        vertical: Constants.screenPadding),
                    child: SpringWidget(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          if (controllersApi.OpeningHoursList.isNotEmpty) {
                            hitApi.value = true;

                            AddRestaurantModel RestaurantData =
                                AddRestaurantModel(
                                    id: 0,
                                    name: controllersApi.nameController.text,
                                    email: controllersApi.EmailController.text,
                                    phone: controllersApi.PhoneController.text,
                                    description: controllersApi
                                        .DescriptionController.text,
                                    image: controllersProvider.imagePath.value,
                                    minimumOrderAmount: controllersApi
                                        .orderlengthController.text,
                                    DeliveryCharges:
                                        controllersApi
                                            .DeliveryChargesController.text,
                                    OpeningHoursList:
                                        controllersApi.OpeningHoursList);

                            AddRestaurantModel updateData = await controllersApi
                                .editRestaurantProfile(RestaurantData);
                            var _pref = DataStroge();
                            _pref.updateUserData(
                                Phone: controllersApi.PhoneController.text,
                                email: controllersApi.EmailController.text,
                                name: controllersApi.nameController.text,
                                photo: updateData.image);

                            hitApi.value = false;
                            Navigator.pop(context);
                            controllersApi.getrestaurantProfileData();
                            // controllersProvider.imagePath.value = '';
                            // nameController.text = '';
                            // DescriptionController.text = '';
                            // AllergensController.text = '';
                            // PhoneController.text = '';
                            // EmailController.text = '';
                            // caloriesController.text = '';
                            // orderlengthController.text = '';
                            // DeliveryChargesController.text = '';

                            _namefocusNode.unfocus();
                            _emailFocusNode.unfocus();
                            _PhonefocusNode.unfocus();
                          } else {
                            FlutterToastDisplay.getInstance
                                .showToast("Please Insert your opening hours");
                          }
                        }
                      },
                      child: RoundButton(
                        margin: 0,
                        gradient: true,
                        loading: hitApi.value,
                        disabled: hitApi.isFalse,
                        height: 50,
                        onTap: () async {},
                        title: 'Save',
                      ),
                    ),
                  ),
                ),
        ),
      );
    });
  }
}

class MyDialog extends StatelessWidget {
  MyDialog({super.key});

  @override
  final controllersApi = Get.put(ProfileViewModel());
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return SimpleDialog(
        title: Text(
          'Set Schedule',
          style: TextStyle(
              color: themecontroller.colorPrimary, fontWeight: FontWeight.w600),
        ),
        children: <Widget>[
          // Weekday Dropdown
          ListTile(
            title: Text('Select a Day:'),
            trailing: Obx(
              () => DropdownButton<String>(
                value: controllersApi.selectedDay.value,
                onChanged: (newValue) {
                  controllersApi.selectedDay.value = newValue!;
                },
                items: <String>[
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),

          // Start Time Picker
          ListTile(
            title: Text('Start Time:'),
            trailing: TextButton(
              onPressed: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  controllersApi.starttime.value = pickedTime.format(context);
                }
              },
              child: Obx(
                () => Text(
                  controllersApi.starttime.value,
                  style: TextStyle(
                      color: themecontroller.colorPrimary,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          // End Time Picker
          ListTile(
            title: Text('End Time:'),
            trailing: TextButton(
              onPressed: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  controllersApi.endtime.value = pickedTime.format(context);
                }
              },
              child: Obx(
                () => Text(
                  controllersApi.endtime.value,
                  style: TextStyle(
                      color: themecontroller.colorPrimary,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          // Save Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  controllersApi.OpeningHoursList.clear();
                },
                child: Text(
                  'Clear All',
                  style: TextStyle(
                      color: themecontroller.colorPrimary,
                      fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (controllersApi.starttime != 'select start time' &&
                      controllersApi.starttime != 'select end time') {
                    bool dayExists = controllersApi.OpeningHoursList.any(
                        (data) =>
                            data.selectedDay ==
                            controllersApi.selectedDay.value);

                    if (dayExists) {
                      FlutterToastDisplay.getInstance
                          .showToast("This day is already exist");
                    } else {
                      OpeningHoursModel hoursData = OpeningHoursModel(
                        startTime: controllersApi.starttime.value,
                        endTime: controllersApi.endtime.value,
                        selectedDay: controllersApi.selectedDay.value,
                      );
                      controllersApi.OpeningHoursList.add(hoursData);
                      FlutterToastDisplay.getInstance.showToast(
                          "${controllersApi.selectedDay.value} Schedule is Successfully Added");
                    }
                  } else {
                    FlutterToastDisplay.getInstance
                        .showToast("Please Select start or end time");
                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                      color: themecontroller.colorPrimary,
                      fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Implement your save logic here
                  Navigator.of(context).pop();
                },
                child: Text(
                  'close',
                  style: TextStyle(
                      color: themecontroller.colorPrimary,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

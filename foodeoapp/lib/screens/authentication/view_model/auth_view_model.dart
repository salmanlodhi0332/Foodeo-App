import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/data/model/user_model.dart';
import 'package:foodeoapp/screens/authentication/view/usertype_screen.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../constant/flutter_toast.dart';
import '../../../constant/navigation.dart';
import '../../../helper/data_storage.dart';
import '../api/authentication_api.dart';
import '../view/verify_otp_screen.dart';

final _pref = DataStroge();

class AuthViewModel extends GetxController {
  final verifyotpFocusNode = FocusNode();
  final countrycodeFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final verifyotp = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    verifyotp.value.dispose();
    nameController.value.dispose();
    emailController.value.dispose();
    passwordController.value.dispose();
    phoneNumber.value.dispose();
    verifyotpFocusNode.dispose();
    countrycodeFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    passwordFocusNode.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  final String fcmToken = DataStroge.fcmToken.value;
  final String deviceId = DataStroge.DeviceID.value;
  final loading = false.obs;
  final toastloading = false.obs;
  final hidepassword = true.obs;
  final processingGoogle = false.obs;
  final processing = false.obs;
  final verificationOtpId = ''.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late BuildContext context;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var selectedUserType = ''.obs;
  RxInt countDown = 60.obs;
  int get countdown => countDown.value;
  RxInt selectedaddress = 0.obs;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      if (countDown.value > 0) {
        countDown.value--;
      } else {
        timer.cancel();
      }
    });
  }

//----------------------SIGN UP WITH Email----------------

  loginWithEmail(
      BuildContext context, String userEmail, String userPassword) async {
    try {
      loading.value = true;
      var userData = UserModel(
          role: selectedUserType.value,
          email: userEmail,
          password: userPassword);

      await AuthenticationApi.getInstance
          .authenticationApi(context, userData, fcmToken, deviceId, 3)
          .then((value) {
        loading.value = false;
        emailController.value.clear();
        passwordController.value.clear();
      }).onError((error, stackTrace) {
        loading.value = false;
        log("errorwithemail ${error}");
      });
    } catch (e) {
      loading.value = false;
      log('NutrientsApirror: $e');
    }
  }

//----------------------SIGN UP WITH Google----------------

  Future<void> signUpWithGoogle(BuildContext context) async {
    try {
      processingGoogle.value = true;
      processing.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        processingGoogle.value = false;
        processing.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        log('User signed in with Google: ${user.displayName}');

        final String? email = googleUser.email;
        final String? name = googleUser.displayName;
        final String? profilePicture = googleUser.photoUrl;

        if (email != null && name != null) {
          var userData =
              UserModel(name: name, role: selectedUserType.value, email: email);

          // ignore: use_build_context_synchronously
          await AuthenticationApi.getInstance
              .authenticationApi(context, userData, fcmToken, deviceId, 2);
        } else {
          print('Email or Name is missing. Unable to send data to API.');
        }
      } else {
        processingGoogle.value = false;
        processing.value = false;
        FlutterToastDisplay.getInstance
            .showToast("Failed to sign in with Google.");

        print('Failed to sign in with Google.');
      }
    } catch (e) {
      processing.value = false;
      processingGoogle.value = false;
      print('Error during Google sign-in: $e');
    }
  }

//---------------------------SEND OTP

  Future<void> mobileOtpSend(var number, BuildContext context) async {
    try {
      log("object 1 ${number}");
      loading.value = true;
      auth.verifyPhoneNumber(
          phoneNumber: number,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (_) {
            log("object 2");
          },
          verificationFailed: (e) {
            log("object 3");
            loading.value = false;
            log(e.toString());
            phoneNumber.value.clear();

            FlutterToastDisplay.getInstance.showToast("Verification failed");
          },
          codeSent: (String verificationId, int? Token) {
            verificationOtpId.value = verificationId;
            log("object 4");
            loading.value = false;
            Navigation.getInstance.screenNavigation(
                context,
                VerifyOtpScreen(
                  phoneNumber: number,
                  verfiyId: verificationOtpId.value,
                ));

            FlutterToastDisplay.getInstance
                .showToast("please check your inbox we will sent to otp");
          },
          codeAutoRetrievalTimeout: (e) {
            log("object 5");
            loading.value = false;
            verificationOtpId.value = '';
            log(e.toString());
          });
    } catch (e) {
      loading.value = false;
      print('object 6 ${e}');

      FlutterToastDisplay.getInstance.showToast("Error sending new code");
    }
  }

//---------------------------VERIFICATION

  Future<void> otpVerification(
      BuildContext context, String verifyId, String phone) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verifyId, smsCode: verifyotp.value.text);
    try {
      loading.value = true;
      log("VF object 11");
      await auth.signInWithCredential(credential).then((value) {
        log("VF object 1");
        print(phone);
        print(value.user);
        var userData = UserModel(
          role: selectedUserType.value,
          phoneNumber: phone,
        );
        AuthenticationApi.getInstance
            .authenticationApi(context, userData, fcmToken, deviceId, 1)
            .then((value) {
          loading.value = false;
          phoneNumber.value.clear();
          verifyotp.value.clear();
        }).onError((error, stackTrace) {
          print("VF object 2");
          loading.value = false;

          FlutterToastDisplay.getInstance.showToast("Error on Registration");

          log('Error on Registration function' + error.toString());
        });
      }).onError((error, stackTrace) {
        verifyotp.value.clear();
        print("VF object 3");
        loading.value = false;
        FlutterToastDisplay.getInstance.showToast("Error on Registration");

        print(error.toString());
      });
    } catch (e) {
      print("VF object 4");
      loading.value = false;
      print(e.toString());

      FlutterToastDisplay.getInstance.showToast("Otp Verification Failed");
    }
  }

  Future<void> sendNewCode(var number) async {
    try {
      verifyotp.value.text = '';

      toastloading.value = true;
      final FirebaseAuth _auth = FirebaseAuth.instance;

      await _auth.verifyPhoneNumber(
        phoneNumber: number,
        timeout: const Duration(seconds: 10),
        verificationCompleted: (AuthCredential authCredential) async {},
        verificationFailed: (authException) {
          toastloading.value = false;
          print("[OTP] $authException");

          FlutterToastDisplay.getInstance.showToast("Verification failed");
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          verificationOtpId.value = verificationId;

          toastloading.value = false;
          FlutterToastDisplay.getInstance.showToast("New code sent");
        },
        codeAutoRetrievalTimeout: (error) {
          verificationOtpId.value = '';

          toastloading.value = false;
          print(error.toString());
        },
      );
    } catch (e) {
      toastloading.value = false;
      print("Error sending new code: $e");

      FlutterToastDisplay.getInstance.showToast("Error sending New Code");
    }
  }

  logout(BuildContext context) async {
    await _pref.logout();
    Navigation.getInstance
        .pagePushAndReplaceNavigation(context, UserTypeScreen());
  }
}

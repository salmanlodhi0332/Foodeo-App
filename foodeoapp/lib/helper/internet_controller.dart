import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetController extends GetxController {
  static InternetController? _instance;
  static InternetController get getInstance =>
      _instance ??= InternetController();

  RxBool isInternetConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    internetCheckerFun();
  }

  internetCheckerFun() async {
    try {
      print('internet Checker hit =================');
      print('$isInternetConnected');
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        isInternetConnected(true);

        return isInternetConnected;
      } else {
        isInternetConnected(false);
        return isInternetConnected;
      }
    } catch (e) {
      print('error in internet_Checker: $e');
    }
  }
}

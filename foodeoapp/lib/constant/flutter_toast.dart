import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodeoapp/constant/theme.dart';

class FlutterToastDisplay {
  static FlutterToastDisplay? _instance;
  static FlutterToastDisplay get getInstance =>
      _instance ??= FlutterToastDisplay();

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ThemeHelper.colortoast,
        textColor: ThemeHelper.colortoasttext,
        fontSize: 16.0);
  }
}

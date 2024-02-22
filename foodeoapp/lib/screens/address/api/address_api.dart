import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodeoapp/services/app_service.dart';
import '../../../constant/constants.dart';
import '../../../constant/flutter_toast.dart';
import '../../../constant/theme.dart';

// var _dio = Dio();

class AddresApi extends AppService {
  static setAddress(int resId, String address, double lat, double long) async {
    try {
      var response = await AppService.getInstance.dio
          .patch(Constants.postUpdateProfile, queryParameters: {
        'restaurantId': resId
      }, data: {
        'address': address,
        'lat': lat,
        'long': long,
      });

      log('UserData==>${address.toString()}');

      log("statusCode =>${response.statusCode}");
      log('Register API done${response.data} 👌✅');

      if (response.statusCode == 201) {
        final json = response.data;
        print(json);
        // Navigator.pop(context);
      } else {
        print('Unknown Error Status Occurred ${(response.data)} ');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        FlutterToastDisplay.getInstance
            .showToast('${e.response!.data['message']}');

        print("Error msg data: ${e.response!.data['message']}");
      } else {
        print("Error sending data: $e");
      }

      throw e;
    }
  }
}

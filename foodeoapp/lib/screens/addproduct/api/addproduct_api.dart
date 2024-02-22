// import 'dart:developer';
// import 'package:foodeoapp/constant/constants.dart';
// import 'package:foodeoapp/screens/addproduct/model/allergens_model.dart';
// import 'package:foodeoapp/screens/addproduct/model/product_detail_model.dart';
// import 'package:foodeoapp/screens/videos/model/nutrients_model.dart';
// import 'package:foodeoapp/services/app_service.dart';

// class AddproductAPi extends AppService {
//   static getAllergens() async {
//     try {
//       final response = await AppService.getInstance.dio.get(
//         Constants.getAllergens,
//       );

//       log("statusCode =>${response.statusCode}");
//       log('get Allergens API done 👌✅');
//       log('Data ${response.data.toString()}');
//       if (response.statusCode == 200) {
//         final responseData = response.data;
//         if (response.statusCode == 200) {
//           final responseData = response.data;

//           if (responseData is Map) {
//             List<AllergensModel> ReelsData = (responseData['allergens'] as List)
//                 .map((data) => AllergensModel.fromjson(data))
//                 .toList();
//             return ReelsData;
//           }
//         } else {
//           return responseData;
//         }
//       }
//     } catch (e) {
//       log("get Allergens Error ==>${e}");
//     }
//   }

//   static getproductData(int productId) async {
//     try {
//       final response = await AppService.getInstance.dio.get(
//           Constants.restaurantProductsByVideo,
//           queryParameters: {"productId": productId});
//       log("statusCode =>${response.statusCode}");
//       log('get product Data API done 👌✅');
//       // print(response.data);
//       if (response.statusCode == 200) {
//         final responseData = response.data;

//         if (responseData is Map) {
//           List<ProductModel> productData = (responseData['product'] as List)
//               .map((data) => ProductModel.fromJson(data))
//               .toList();

//           print('productData: $productData');

//           return productData;
//         } else {
//           return responseData;
//         }
//       }
//     } catch (e) {
//       log("getrestaurantData Error ==>${e}");
//     }
//   }
// }

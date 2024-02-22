import 'dart:developer';
import 'package:get/get.dart';
import '../model/nutrients_model.dart';
import '../api/nutrient_api.dart';

class NutrientsViewModel extends GetxController {
  RxList<Nutrients> nutrientsList = <Nutrients>[].obs;
  RxList<Allergens> allergensList = <Allergens>[].obs;
  RxBool isLoading = true.obs;

  getPrdouctNutrients(int productId) async {
    try {
      var serverResponse = await NutrientsAPi.getPrdouctNutrients(productId);
      log("ServerResponse ${serverResponse}");
      isLoading.value = false;

      var allergenList = (serverResponse['allergens'] as List<dynamic>)
          .map<Allergens>((data) => Allergens.fromjson(data))
          .toList();
      allergensList.value = allergenList;

      log(allergensList.toString());
      var nutrientList = (serverResponse['nutrients'] as List<dynamic>)
          .map<Nutrients>((data) => Nutrients.fromjson(data))
          .toList();
      nutrientsList.value = nutrientList;
      log(nutrientsList.toString());
    } catch (e) {
      isLoading.value = false;
      log('NutrientsApirror: $e');
    }
  }

  List<NutrientsModel> nutreintsdummy() {
    return [
      NutrientsModel(allergens: [
        Allergens(
            productId: 1,
            allergens: 'Egg',
            image: 'assets/images/allergens4.png'),
        Allergens(
            productId: 1,
            allergens: 'Nuts',
            image: 'assets/images/allergens1.png'),
        Allergens(
            productId: 1,
            allergens: 'Milk',
            image: 'assets/images/allergens2.png'),
        Allergens(
            productId: 1,
            allergens: 'Mushrooms',
            image: 'assets/images/allergens3.png')
      ], nutrients: [
        Nutrients(
            productId: 1,
            nutritional_values: '12g',
            nutritional_names: 'Calories'),
        Nutrients(
            productId: 1,
            nutritional_values: '12g',
            nutritional_names: 'Total Fat'),
        Nutrients(
            productId: 1,
            nutritional_values: '12g',
            nutritional_names: 'Sugar'),
        Nutrients(
            productId: 1,
            nutritional_values: '12g',
            nutritional_names: 'Saturated'),
        Nutrients(
            productId: 1,
            nutritional_values: '12g',
            nutritional_names: 'Total Fat'),
        Nutrients(
            productId: 1, nutritional_values: '12g', nutritional_names: 'Sugar')
      ])
    ];
  }
}

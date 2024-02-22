import 'package:foodeoapp/screens/addproduct/api/addproduct_api.dart';
import 'package:foodeoapp/screens/addproduct/model/allergens_model.dart';
import 'package:foodeoapp/screens/addproduct/model/product_detail_model.dart';
import 'package:foodeoapp/screens/videos/api/video_api.dart';
import 'package:foodeoapp/screens/videos/model/nutrients_model.dart';
import 'package:foodeoapp/screens/videos/model/nutrients_model.dart';
import 'package:foodeoapp/screens/videos/model/tags_model.dart';
import 'package:get/get.dart';

class AddProductViewModel extends GetxController {
  final selectedIndex = 0.obs;

  RxList<Nutrients> NutrientList = <Nutrients>[].obs;
  RxList<AllergensModel> AllergensList = <AllergensModel>[].obs;
  RxList<ProductModel> producrtData = <ProductModel>[].obs;
  RxList<AllergensModel> SelectAllergensList = <AllergensModel>[].obs;
  RxList<AllergensModel> SelectTagsList = <AllergensModel>[].obs;
  
  var Isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // getReels();
  }

  addNutritions(String nutritionalvalues, String nutritionalnames) {
    var NutrientsData = Nutrients(
      productId: 0,
      nutritional_values: nutritionalvalues,
      nutritional_names: nutritionalvalues,
    );
    NutrientList.add(NutrientsData);
    print('addNutritions');
    print(NutrientList.length);
  }

  getAllAllergens() async {
    try {
      Isloading.value = true;
      // final Data = await AddproductAPi.getAllergens();
      // AllergensList.value = Data;
      // update();
      print(AllergensList.length);
      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('errorget All Allergens view model:$e');
    }
  }

  getproductData(int productId) async {
    try {
      Isloading.value = true;
      // final ProductData = await AddproductAPi.getproductData(productId);

      // producrtData.value = ProductData;

      // update();
      print('producrtData: ${producrtData.length}');

      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('error get Product Reviews view model:$e');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}

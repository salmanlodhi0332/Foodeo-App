import 'package:foodeoapp/screens/explorepage/api/explore_api.dart';
import 'package:foodeoapp/screens/explorepage/model/explore_model.dart';
import 'package:foodeoapp/screens/videos/api/video_api.dart';
import 'package:foodeoapp/screens/videos/model/tags_model.dart';
import 'package:get/get.dart';

class ExploreViewModel extends GetxController {
  final selectedIndex = 0.obs;

  RxList<ExploreModel> PopularProductList = <ExploreModel>[].obs;
  RxList<ExploreModel> RecommendedProductList = <ExploreModel>[].obs;
  RxList<ExploreModel> PopularProductPageList = <ExploreModel>[].obs;
  RxList<ExploreModel> RecommendedProductPageList = <ExploreModel>[].obs;
  RxList<ExploreModel> SaerchList = <ExploreModel>[].obs;
  RxList<tags_model> tagsList = <tags_model>[].obs;
  final RxString selectedTags = ''.obs;
  var Isloading = false.obs;
  var RecommendedProductIsloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getExploreData();
  }

  getExploreData() async {
    try {
      Isloading.value = true;
      final ExploreData = await ExploreAPI.getExploreData();

      PopularProductList.value = ExploreData['PopularData'];
      RecommendedProductList.value = ExploreData['RecommendedData'];

      tagsList.value = ExploreData['tags'];

      print('PopularProductList: ${PopularProductList.length}');
      print('RecommendedProductList: ${RecommendedProductList.length}');
      print('tagsList: ${tagsList.length}');

      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('error getExploreData view model:$e');
    }
  }

  getPopulerProductData() async {
    try {
      Isloading.value = true;
      final PopularData = await ExploreAPI.getPopulerProductData();

      PopularProductPageList.value = PopularData;

      print('PopularProductPageList: ${PopularProductPageList.length}');
      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('error getPopulerProductData view model:$e');
    }
  }

  getRecommendedProductData() async {
    try {
      Isloading.value = true;
      final RecommendedData = await ExploreAPI.getRecommendedProductData();

      RecommendedProductPageList.value = RecommendedData;

      print('RecommendedProductPageList: ${RecommendedProductPageList.length}');
      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('error getRecommendedProductData view model:$e');
    }
  }

  getRecommendedProductDataByTag(String tag) async {
    try {
      RecommendedProductIsloading.value = true;
      final RecommendedData = await ExploreAPI.getProductDataByTags(tag);

      RecommendedProductPageList.value = RecommendedData;

      print(
          'getRecommendedProductDataByTaglist: ${RecommendedProductPageList.length}');
      RecommendedProductIsloading.value = false;
    } catch (e) {
      RecommendedProductIsloading.value = false;
      print('error getRecommendedProductDataByTag view model:$e');
    }
  }

  getSearchProduct(String search) async {
    try {
      RecommendedProductIsloading.value = true;
      final SearchData = await ExploreAPI.getSearchProduct(search);

      SaerchList.value = SearchData;

      print('SaerchList: ${SaerchList.length}');
      RecommendedProductIsloading.value = false;
    } catch (e) {
      RecommendedProductIsloading.value = false;
      print('error getRecommendedProductDataByTag view model:$e');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}

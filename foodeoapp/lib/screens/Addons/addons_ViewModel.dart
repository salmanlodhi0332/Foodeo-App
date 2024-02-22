import 'package:foodeoapp/screens/Addons/api/addons_api.dart';
import 'package:foodeoapp/screens/Addons/model/addons_model.dart';
import 'package:get/get.dart';

class AddonsViewModel extends GetxController {
  final selectedIndex = 0.obs;
  final List<AddonModel> selectedAddons = [];
  final RxList<AddonModel> AddonsList = <AddonModel>[].obs;

  var loading = false.obs;
  RxDouble slideDistance = 0.0.obs;
  final RxDouble total = 0.0.obs;
  final RxBool isSelected = false.obs;
  @override
  void onInit() {
    super.onInit();
    print('AddonsViewModel');
    slideDistance.value = -200.0;
    Future.delayed(Duration(milliseconds: 500), () {
      slideDistance.value = 0;
      update();
      print(slideDistance);
    });
    // loadRelatedPosts();
  }

  getAddonsByProductId(int productId) async {
    try {
      loading.value = true;
      final RecommendedData = await AddonsAPI.getAddonsByProductId(productId);

      AddonsList.value = RecommendedData;

      print('getAddonsByProductId: ${AddonsList.length}');
      loading.value = false;
    } catch (e) {
      loading.value = false;
      print('error getAddonsByProductId view model:$e');
    }
  }

  AddAddons(int productId, int addonsId, int action) async {
    try {
      loading.value = true;
      final total = await AddonsAPI.AddAddons(productId, addonsId, action);

      total.value = total;

      loading.value = false;
    } catch (e) {
      loading.value = false;
      print('error getAddonsByProductId view model:$e');
    }
  }

  @override
  void onClose() {
    // pageController.dispose();
    // communityAPI = null;
    slideDistance.value = -200.0;
    super.onClose();
  }
}

import 'package:foodeoapp/data/model/review_model.dart';
import 'package:foodeoapp/screens/videos/api/reviews_api.dart';
import 'package:get/get.dart';

class ReviewViewModel extends GetxController {
  RxList<reviewModel> reviewsList = <reviewModel>[].obs;
  RxBool Isloading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  getProductReviews(int productId) async {
    try {
      Isloading.value = true;
      final reviewData = await ReviewsAPi.getPrdouctReviews(productId);
      reviewsList.value = reviewData;
      // update();
      print(reviewsList.length);
      Isloading.value = false;
    } catch (e) {
      print('error get Product Reviews view model:$e');
    }
  }
}

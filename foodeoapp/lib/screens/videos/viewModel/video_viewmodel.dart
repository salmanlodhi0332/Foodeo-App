import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodeoapp/helper/compressor.dart';
import 'package:foodeoapp/screens/addproduct/model/allergens_model.dart';
import 'package:foodeoapp/screens/videos/model/addServiceprovider.dart';
import 'package:foodeoapp/screens/videos/model/add_video_model.dart';
import 'package:foodeoapp/screens/videos/model/nutrients_model.dart';
import 'package:foodeoapp/screens/videos/model/openinnghour_model.dart';
import 'package:foodeoapp/screens/videos/model/serviceprovider_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:foodeoapp/screens/videos/api/video_api.dart';
import 'package:foodeoapp/screens/videos/model/tags_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../model/video_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:video_compress/video_compress.dart';

class VideoViewModel extends GetxController {
  final selectedIndex = 0.obs;
  final videothembnail = "".obs;
  final RxString videoContent = "".obs;

  bool uploaded = false;
  RxBool compressing = false.obs;
  double progress = 0;

  final serviceproviderController = TextEditingController().obs;
  RxList<VideoModel> reelsVideos = <VideoModel>[].obs;
  RxList<tags_model> tagsList = <tags_model>[].obs;
  RxList<ServiceProviderModel> ServiceProviderList =
      <ServiceProviderModel>[].obs;
  RxInt SelectedProvider = 0.obs;
  RxString selectedProviderName = ''.obs;
  RxList<tags_model> SelectedtagsList = <tags_model>[].obs;
  var Isloading = false.obs;
  final RxString selectedTags = ''.obs;

  var liked = false.obs;
  final RxBool settingopen = false.obs;

  RxList<Nutrients> NutrientList = <Nutrients>[].obs;
  RxList<AllergensModel> AllergensList = <AllergensModel>[].obs;
  RxList<AddServiceProviderModel> ServiceProviderDataList =
      <AddServiceProviderModel>[].obs;
  RxList<AllergensModel> SelectAllergensList = <AllergensModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getReels();
    gettags();
  }

  addNutritions(String nutritionalvalues, String nutritionalnames) {
    var NutrientsData = Nutrients(
      productId: 0,
      nutritional_values: nutritionalvalues,
      nutritional_names: nutritionalnames,
    );
    NutrientList.add(NutrientsData);
    print('addNutritions');
    print(NutrientList.length);
  }

  addserviceProvider(
      int serivceId, String serverProvidername, String serverProviderUrl) {
    var Data = AddServiceProviderModel(
        id: serivceId, name: serverProvidername, orderUrl: serverProviderUrl);
    ServiceProviderDataList.add(Data);
    print('addNutritions');
    print(NutrientList.length);
  }

  getAllAllergens() async {
    try {
      Isloading.value = true;
      final Data = await VideoReelsAPI.getAllergens();
      AllergensList.value = Data;
      // update();
      print(AllergensList.length);
      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('errorget All Allergens view model:$e');
    }
  }

  // getproductData(int productId) async {
  //   try {
  //     Isloading.value = true;
  //     final ProductData = await VideoReelsAPI.getproductData(productId);

  //     producrtData.value = ProductData;

  //     // update();
  //     print('producrtData: ${producrtData.length}');

  //     Isloading.value = false;
  //   } catch (e) {
  //     Isloading.value = false;
  //     print('error get Product Reviews view model:$e');
  //   }
  // }

  getReels() async {
    try {
      Isloading.value = true;
      final reelsData = await VideoReelsAPI.getreels();
      reelsVideos.value = reelsData;
      // update();
      print(reelsVideos.length);
      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('error get Product Reviews view model:$e');
    }
  }

  gettags() async {
    try {
      Isloading.value = true;
      final tagsData = await VideoReelsAPI.getAllTags();
      tagsList.value = tagsData;
      print(tagsList.length);
      Isloading.value = false;
    } catch (e) {
      print('error get Product Reviews view model:$e');
    }
  }
/// toggle =1 --> like
/// toggle =0 --> dislike
  addOrRemoveyummy(int toggle, int videoId) async {
    try {
      Isloading.value = true;
      await VideoReelsAPI.addOrRemoveyummy(toggle, videoId);
      // tagsList.value = tagsData;
      // print(tagsList.length);
      Isloading.value = false;
    } catch (e) {
      print('error get Product Reviews view model:$e');
    }
  }

  getServiceProvider() async {
    try {
      Isloading.value = true;
      final tagsData = await VideoReelsAPI.getServiceProvider();
      ServiceProviderList.value = tagsData;
      print(ServiceProviderList.length);
      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('error get Product Reviews view model:$e');
    }
  }

  getReelsbyatg(String tag) async {
    try {
      Isloading.value = true;
      final reelsData = await VideoReelsAPI.getreelsbyTags(tag);
      print(reelsData);
      if (reelsData is List && reelsData.isEmpty) {
        print('Reels data is empty for $tag');
        // Clear the screen or take appropriate action here
      } else {
        if (reelsData is List<VideoModel>) {
          print('get reels by $tag');
          reelsVideos.clear();
          reelsVideos.value = reelsData;
        }
      }

      print(reelsVideos.length);
      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('error get Product Reviews view model: $e');
    }
  }

  addVideo(AddVideoModel videoData) async {
    try {
      Isloading.value = true;
      print(videoData);
      // final reelsData =
      await VideoReelsAPI.uploadReel(videoData);
      Isloading.value = false;
      // return reelsData;
    } catch (e) {
      Isloading.value = false;
      print('error get Product Reviews view model: $e');
    }
  }

  Future<void> upload({
    required String caption,
    required String filePath,
  }) async {
    uploaded = false;

    Subscription _subscription =
        VideoCompress.compressProgress$.subscribe((progress) {
      debugPrint('progress: $progress');
      this.progress = progress;
    });

    MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      filePath,
      quality: VideoQuality.DefaultQuality,
      deleteOrigin: false, // It's false by default
    );
    if (mediaInfo != null) {
      compressing.value = false;

      print(mediaInfo.duration);
      // AppService.getInstance.uploadVideo(
      //   mediaInfo.path!,
      //   caption,
      //   mediaInfo.duration!,
      //   (count, total) {
      //     progress = count / total;
      //     progress = progress * 100;
      //     debugPrint('progress: $progress');
      //     notifyListeners();
      //   },
      //   soundId: soundId,
      //   allowComments: allowComments,
      //   allowSharing: allowSharing,
      //   private: private,
      //   allowDuet: allowDuet,
      //   allowGifts: receiveGifts,
      //   exclusiveDiamond: exclusiveAmount,
      //   isAd: isAd,
      //   clickableUrl: clickableUrl,
      //   days: days,
      //   budget: budget,
      //   forSubscriber: forSubscriber,
      //   tagUserIds: tagUserIds,
      //   productIds: productIds,
      // ).then((value) {
      //   print("Response: $value");
      //   this.progress = 0;
      //   uploaded = true;
      //   running = false;
      //   eventBus.fire(VideoUploaded(value!));
      // }).catchError((error) {
      //   print("Response error: $error");
      //   eventBus.fire(VideoUploaded(null));
      //   uploaded = false;
      //   running = false;
      // }).whenComplete(() {
      //   notifyListeners();
      // });
    } else {
      log("Compressed is empty");
    }
  }

  final Rx<File?> _video = Rx<File?>(null);
  final picker = ImagePicker();

  Future<void> getVideoGallery() async {
    try {
      final pickedFile = await picker.pickVideo(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.rear,
        maxDuration: const Duration(minutes: 5),
      );
      if (pickedFile != null) {
        _video.value = File(pickedFile.path);
        videothembnail.value = '';
        print('before compress :${_video.value}');
        compressing.value = true;
        var video = await NativeCompressor.compressVideo(File(pickedFile.path));
        compressing.value = true;
        print('after compress :${video!.path}');
        videoContent.value = video!.path;
        log('Uploaded video: ${_video.value?.path}');
        final thumbData = await VideoThumbnail.thumbnailFile(
          video: _video.value!.path,
          thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: 250,
          quality: 90,
        );
        videothembnail.value = thumbData!;
        log('Thumbnail video: $thumbData');
      } else {
        log('No Video Picked');
      }
    } catch (e) {
      log('Error picking video: $e');
    }
  }
  // static Future<File?> compressVideo(File file) async {
  //   MediaInfo? mediaInfo = await VideoCompress.compressVideo(
  //     file.path,
  //     quality: VideoQuality.DefaultQuality,
  //     includeAudio: true,
  //     deleteOrigin: false, // It's false by default
  //   );
  //   var videoFile = mediaInfo!.file;
  //   return videoFile;
  // }
}

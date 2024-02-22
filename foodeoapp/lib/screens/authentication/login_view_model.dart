import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  Rx<ScrollController> scrollController1 = ScrollController().obs;
  Rx<ScrollController> scrollController2 = ScrollController().obs;
  Rx<ScrollController> scrollController3 = ScrollController().obs;
  List imagelist = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1msyQdz3zmxLzR9pSP6O3SjzAseLvL8v-vg&usqp=CAU',
    'https://nishathotels.com/wp-content/uploads/2022/11/blog-cover-famous-food-.jpg',
    'https://a.cdn-hotels.com/gdcs/production0/d1513/35c1c89e-408c-4449-9abe-f109068f40c0.jpg?impolicy=fcrop&w=800&h=533&q=medium',
    'https://static1.squarespace.com/static/53b839afe4b07ea978436183/53bbeeb2e4b095b6a428a13e/5fd2570b51740e23cce97919/1678505081247/traditional-food-around-the-world-Travlinmad.jpg?format=1500w',
    'https://media.licdn.com/dms/image/D4E12AQFj4wQ57JuV8g/article-cover_image-shrink_720_1280/0/1673101565086?e=2147483647&v=beta&t=8qw3zWaLS2fQp_-1_rUPWDPUbOeTEp4eu4--GieV2O4',
    'https://cdn.vox-cdn.com/thumbor/-iZDFxrJBrcd44Fa3kKfdz6u0wI=/0x0:2990x3737/1200x0/filters:focal(0x0:2990x3737):no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/24558613/bang_bang_noodles.jpeg',
  ];

  @override
  void onInit() {
    super.onInit();
    startAutoScroll();
  }

  @override
  void onClose() {
    scrollController1.value.dispose();
    scrollController2.value.dispose();
    scrollController3.value.dispose();
    super.onClose();
  }

  void startAutoScroll() {
    Future.delayed(Duration.zero, () {
      animateToMaxMin(scrollController1.value, 1);
      animateToMaxMin(scrollController2.value, 2);
      animateToMaxMin(scrollController3.value, 3);
    });
  }

  void animateToMaxMin(ScrollController controller, int seconds) {
    double min = controller.position.minScrollExtent;
    double max = controller.position.maxScrollExtent;
    double direction = max;

    Timer.periodic(Duration(seconds: seconds), (timer) {
      controller.animateTo(
        direction,
        duration: Duration(seconds: 8),
        curve: Curves.linear,
      );
      direction = direction == max ? min : max;
    });
  }
}

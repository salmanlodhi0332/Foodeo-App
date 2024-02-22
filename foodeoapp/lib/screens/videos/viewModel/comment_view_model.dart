import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodeoapp/data/model/comment_model.dart';
import 'package:foodeoapp/screens/videos/api/comment_api.dart';
import 'package:get/get.dart';

class CommentViewModel extends GetxController {
  RxList<CommentModel> commentList = <CommentModel>[].obs;
  RxBool isloading = false.obs;
  RxBool apihitting = false.obs;
  final commentController = TextEditingController().obs;
  final commentFocusNode = FocusNode();
  RxBool emojiShowing = false.obs;

  @override
  void dispose() {
    super.dispose();
    commentController.value.dispose();
    commentFocusNode.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    commentFocusNode.addListener(() {
      if (commentFocusNode.hasFocus) {
        emojiShowing.value = false;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  onBackspacePressed() {
    commentController.value
      ..text = commentController.value.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: commentController.value.text.length));
  }

  getPrdouctComment(int productId) async {
    try {
      isloading.value = true;
      final commentData = await CommentAPi.getPrdouctComment(productId);
      log('commentData$commentData');
      commentList.value = commentData;

      print(commentList.length);
      isloading.value = false;
    } catch (e) {
      isloading.value = false;
      print('error get Product Comment :$e');
    }
  }

  postPrdouctComment(int productId, String comments) async {
    try {
      // isloading.value = true;
      final commentData =
          await CommentAPi.postPrdouctComment(productId, comments);

      commentController.value.clear();

      if (commentData is List) {
        final List<CommentModel> commentsList = commentData.map((commentJson) {
          return CommentModel.fromJson(commentJson);
        }).toList();

        print('ResponseComments: $commentsList');
        commentList.addAll(commentsList);
        // isloading.value = false;
      } else {
        print('Unexpected data format from the API');
      }
    } catch (e) {
      // isloading.value = false;
      print('error Post Product Commenst:$e');
    }
  }
}

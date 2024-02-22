

import 'package:get/get.dart';

class VideoModel {
  int id;
  int productId;
  int userId;
  int restaurantId;
  String username;
  String userPicture;
  String title;
  String productDetails;
  String productPrice;
  String content;
  String? orderUrl;
  RxBool liked;
  String? thumbnail;
  int? yummiesCount;
  int? reviewsCount;
  List<String> tags;
  DateTime createdAt;
  DateTime updatedAt;

  VideoModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.restaurantId,
    required this.userPicture,
    required this.username,
    required this.title,
    required this.productDetails,
    required this.productPrice,
    required this.liked,
    required this.tags,
    required this.content,
    this.orderUrl,
    this.thumbnail,
    required this.yummiesCount,
    required this.reviewsCount,
    // required this.reviews,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
        id: json['id'] ?? 0,
        productId: json['productId'] ?? 0,
        title: json['title'] ?? '',
        productDetails: json['productDetails'] ?? '',
        content: json['content'] ?? '',
        yummiesCount: json['yummiesCount'] ?? 0,
        reviewsCount: json['reviewsCount'] ?? 0,
        orderUrl: json['order_url'] ?? '',
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        userId: json['userId'] ?? 0,
        thumbnail: json['thumbnail'] ?? '',
        restaurantId: json['restaurant_id'] ?? 0,
        userPicture: json['userPicture'] ?? '',
        username: json['username'] ?? '',
        tags: List<String>.from(json['tags']),
        liked: RxBool(json['liked']),
        productPrice: json['productPrice'].toString() ?? '0');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'title': title,
      'product_details': productDetails,
      'content': content,
      'order_url': orderUrl,
      // 'reviews': reviews,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}

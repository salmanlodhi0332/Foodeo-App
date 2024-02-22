import 'package:get/get.dart';

class reviewModel {
  int id;
  int productId;
  int userId;
  String username;
  String userPicture;
  String comment;
  double rating;
  DateTime createdAt;
  // DateTime updatedAt;

  reviewModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userPicture,
    required this.username,
    required this.comment,
    required this.rating,
    required this.createdAt,
    // required this.updatedAt,
  });

  factory reviewModel.fromJson(Map<String, dynamic> json) {
    return reviewModel(
      id: json['id'] as int,
      productId: json['productId'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      // updatedAt: DateTime.parse(json['updated_at'] as String),
      userId: json['userId'],
      userPicture: json['userImage'] == '' ? '' : json['userImage'],
      username: json['userName'] == '' ? '' : json['userName'],
      comment: json['reviews'] == '' ? '' : json['reviews'],
      rating: json['rating'] == null ? 0.0 : json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'user_id': userId,
      'userPicture': userPicture,
      'username': username,
      'comment': comment,
      'rating': rating,
      'created_at': createdAt.toIso8601String(),
      // 'updated_at': updatedAt.toIso8601String(),
    };
  }
}

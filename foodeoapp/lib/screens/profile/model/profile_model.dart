// Restaurant Model
class RestaurantModel {
  final int ownerID;
  final String ownerName;
  final String restaurantBio;
  final String restaurantImage;
  final double ratingsAverage;
  final String dishes;
  final int yummiesCount;
  final int ordersCount;
  // final List<VideoContent> Video_Content;

  RestaurantModel({
    required this.ownerID,
    required this.ownerName,
    required this.restaurantBio,
    required this.restaurantImage,
    required this.dishes,
    required this.ratingsAverage,
    required this.yummiesCount,
    required this.ordersCount,
    // required this.Video_Content
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    // final List<dynamic> videoContentsJson = json['video_contents'];
    // final List<VideoContent> videoContents = videoContentsJson
    //     .map((videoJson) => VideoContent.fromJson(videoJson))
    //     .toList();

    return RestaurantModel(
        ownerID: json['owner_id'],
        ownerName: json['owner_name'],
        restaurantBio:
            json['restaurant_bio'] == null ? '' : json['restaurant_bio'],
        restaurantImage:
            json['restaurant_image'] == '' ? '' : json['restaurant_image'],
        ratingsAverage: json['ratings_average'].toDouble() == null
            ? 0.0
            : json['ratings_average'].toDouble(),
        yummiesCount: json['yummies_count'] ?? '',
        ordersCount: json['orders_count'] ?? '',
        dishes: json['dishes'].toString() ?? ''

        // Video_Content: videoContents
        );
  }
}

// Video Content Model
class VideoContent {
  final int yummiesCount;
  final int ordersCount;
  final String videoContent;
  final DateTime createdAt;

  VideoContent({
    required this.yummiesCount,
    required this.ordersCount,
    required this.videoContent,
    required this.createdAt,
  });

  factory VideoContent.fromJson(Map<String, dynamic> json) {
    return VideoContent(
      yummiesCount: json['yummies_count'] ?? 0,
      ordersCount: json['orders_count'] == null ? 0 : json['orders_count'],
      videoContent: json['video_content'] == null ? '' : json['video_content'],
      createdAt:
          DateTime.parse(json['created_at'] == null ? '' : json['created_at']),
    );
  }
}

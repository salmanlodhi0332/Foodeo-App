class ProductModel {
  // final int videoId;
  final int productId;
  final String productName;
  final String productDetails;
  final double productPrice;
  final String productImage;
  final int reviewsCount;
  final String ratingsAverage;
  final String deliveryRadius;

  ProductModel({
    // required this.videoId,
    required this.productId,
    required this.productName,
    required this.productDetails,
    required this.productPrice,
    required this.productImage,
    required this.reviewsCount,
    required this.ratingsAverage,
    required this.deliveryRadius,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      // videoId: json['video_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productDetails: json['product_details'],
      productPrice: double.parse(json['product_price']),
      productImage: json['product_image'],
      reviewsCount: json['reviews_count'],
      ratingsAverage: json['ratings_average'].toString(),
      deliveryRadius: json['delivery_radius'].toString(),
    );
  }
}

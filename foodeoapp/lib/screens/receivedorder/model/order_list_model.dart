class OrderListModel {
  final int orderId;
  final int restaurantId;
  final String restaurantName;
  final String restaurantImage;
  final int userId;
  final double subTotal;
  final String deliveryStatus;
  final int orderStatus;
  final int productId;
  final String productName;
  final String productDetails;
  final String quantity;
  final String productImage;
  final double deliveryRadius;
  OrderListModel({
    required this.orderId,
    required this.restaurantId,
    required this.userId,
    required this.restaurantImage,
    required this.restaurantName,
    required this.subTotal,
    required this.deliveryStatus,
    required this.orderStatus,
    required this.productId,
    required this.productName,
    required this.productDetails,
    required this.quantity,
    required this.productImage,
    required this.deliveryRadius,
  });

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'restaurant_id': restaurantId,
      'user_id': userId,
      'sub_total': subTotal,
      'delivery_status': deliveryStatus,
      'order_status': orderStatus,
      'product_id': productId,
      'product_name': productName,
      'product_details': productDetails,
      'quantity': quantity,
      'delivery_radius': deliveryRadius,
      'product_image': productImage,
    };
  }

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      orderId: json['order_id'] ?? 0,
      restaurantId: json['restaurant_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      subTotal: json['sub_total'] != null ? json['sub_total'].toDouble() : 0.0,
      orderStatus: json['order_status'] ?? 0,
      productId: json['product_id'] ?? 0,
      productName: json['product_name'] ?? '',
      productDetails: json['product_details'] ?? '',
      quantity: json['quantity'] ?? '',
      productImage: json['product_image'] ?? '',
      deliveryStatus: json['delivery_status'] ?? '',
      restaurantName: json['restaurant_name'] ?? '',
      restaurantImage: json['restaurant_image'] ?? '',
      deliveryRadius: json['delivery_radius'] != null
          ? json['delivery_radius'].toDouble()
          : 0.0,
    );
  }
}

class OrderDeliveryModel {
  final int? id;
  final String? name;
  final String? time;
  final String? deliveryFees;
  final String? serviceFees;
  final String? deliveryImage;
  final String? orderUrl;

  OrderDeliveryModel({
    this.id,
    this.name,
    this.time,
    this.deliveryFees,
    this.serviceFees,
    this.deliveryImage,
    this.orderUrl,
  });

  factory OrderDeliveryModel.fromJson(Map<String, dynamic> json) {
    return OrderDeliveryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      time: json['time'] ?? '',
      deliveryFees: json['delivery_fees'] ?? '',
      serviceFees: json['service_fees'] ?? '',
      deliveryImage: json['image'] ?? '',
      orderUrl: json['order_url'] ?? '',
    );
  }
}

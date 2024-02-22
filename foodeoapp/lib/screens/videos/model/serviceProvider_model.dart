class ServiceProviderModel {
  final int id;
  final String name;
  final String time;
  final double deliveryFees;
  final double serviceFees;
  final String image;
  final String orderUrl;

  ServiceProviderModel({
    required this.id,
    required this.name,
    required this.time,
    required this.deliveryFees,
    required this.serviceFees,
    required this.image,
    required this.orderUrl,
  });

  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderModel(
      id: json['id'] as int,
      name: json['name'] as String,
      time: json['time'] as String,
      deliveryFees: double.parse(json['delivery_fees']),
      serviceFees: double.parse(json['service_fees']),
      image: json['image'] as String,
      orderUrl: json['order_url'] as String,
    );
  }
}




class AddServiceProviderModel {
  final int id;
  final String name;
  final String orderUrl;

  AddServiceProviderModel({
    required this.id,
    required this.name,
    required this.orderUrl,
  });

  factory AddServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return AddServiceProviderModel(
      id: json['id'] as int,
      name: json['name'] as String,
      orderUrl: json['order_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'order_url': orderUrl,
    };
  }
}

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AddonModel {
  final int id;
  final String name;
  final String price;
  final String picture;
  final RxBool selected; // Add the RxBool property

  AddonModel({
    required this.id,
    required this.name,
    required this.price,
    required this.picture,
    bool selected = false, // Provide a default value
  }) : selected = RxBool(selected); // Initialize the RxBool property

  factory AddonModel.fromJson(Map<String, dynamic> json) {
    return AddonModel(
      id: json['addon_id'] ?? 0,
      name: json['addon_name'] ?? '',
      price: json['addon_price'],
      picture: json['addon_icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'picture': picture,
    };
  }
}

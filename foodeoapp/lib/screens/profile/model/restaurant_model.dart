import 'package:foodeoapp/screens/videos/model/openinnghour_model.dart';

class AddRestaurantModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? description;
  final String? image;
  final String? minimumOrderAmount;
  final String? DeliveryCharges;
  final List<OpeningHoursModel>? OpeningHoursList;

  AddRestaurantModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.description,
    this.image,
    this.minimumOrderAmount,
    this.DeliveryCharges,
    this.OpeningHoursList,
  });

  factory AddRestaurantModel.fromJson(Map<String, dynamic> json) {
    return AddRestaurantModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      minimumOrderAmount: json['minimumOrderAmount'] ?? '',
      DeliveryCharges: json['DeliveryCharges'] ?? '',
      OpeningHoursList: (json['timings'] as List).isEmpty
          ? []
          : (json['timings'] as List)
              .map((e) => OpeningHoursModel.fromJson(e))
              .toList(),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'token': token,
  //     'id': id,
  //     'name': name,
  //     'email': email,
  //     'phone': phone,
  //     'role': role,
  //     'image': image,
  //   };
  // }
}

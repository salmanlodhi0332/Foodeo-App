import 'package:foodeoapp/helper/data_storage.dart';

class EditRestaurant {
  String? name;
  String? description;
  String? image;
  String? lat;
  String? lon;
  String? phoneNumber;
  String? cuisineTypes;
  String? deliveryArea;
  String? additionalInformation;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? accountId;
  int? deliveryRadius;
  double? deliveryCharges;
  String? address;
  String? bankAccount;
  String? minimum_amount;

  EditRestaurant(
      {this.name,
      this.description,
      this.image,
      this.lat,
      this.lon,
      this.phoneNumber,
      this.cuisineTypes,
      this.deliveryArea,
      this.additionalInformation,
      this.createdAt,
      this.updatedAt,
      this.accountId,
      this.deliveryRadius,
      this.deliveryCharges,
      this.address,
      this.bankAccount,
      this.minimum_amount});

  factory EditRestaurant.fromJson(Map<String, dynamic> json) {
    return EditRestaurant(
      name: json['name'],
      description: json['description'],
      image: json['image'] ?? '',
      lat: json['lat'],
      lon: json['lon'],
      phoneNumber: json['phone_number'],
      cuisineTypes: json['cuisine_types'],
      deliveryArea: json['delivery_area'],
      additionalInformation: json['additional_information'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      accountId: json['account_id'],
      deliveryRadius: json['delivery_radius'],
      deliveryCharges: json['delivery_charges'].toDouble(),
      address: json['address'],
      bankAccount: json['bank_account'],
      minimum_amount: json['minimum_amount'],
    );
  }
}

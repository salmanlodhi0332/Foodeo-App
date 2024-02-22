import 'package:get/get_rx/get_rx.dart';

import '../../Addons/model/addons_model.dart';

class Product {
  final String? productName;
  final String? productImage;
  final double? productPrice;

  Product({this.productName, this.productPrice, this.productImage});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['product_name'],
      productImage: json['product_image'],
      productPrice: json['product_price'].toDouble() ?? 0.0,
    );
  }
}

class Restaurant {
  final int? restaurantId;
  final String? restaurantName;
  final String? restaurantImage;
  final String? restaurantEmail;

  Restaurant({
    this.restaurantId,
    this.restaurantName,
    this.restaurantImage,
    this.restaurantEmail,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        restaurantId: json['restaurant_id'] ?? 0,
        restaurantName: json['restaurant_name'] ?? '',
        restaurantImage: json['restaurant_image'] ?? '',
        restaurantEmail: json['restaurant_email'] ?? '');
  }
}

class ProductQuantityModel {
  RxInt? quantity;
  final double? mainItem;
  // final double? totalAddons;
  final RxDouble? subTotal;

  ProductQuantityModel({
    this.quantity,
    this.mainItem,
    // this.totalAddons,
    this.subTotal,
  });

  factory ProductQuantityModel.fromJson(Map<String, dynamic> json) {
    return ProductQuantityModel(
      quantity: RxInt(json['quantity'] ?? 0),
      mainItem: json['main_item'].toDouble() ?? 0.0,
      // totalAddons: json['total_addons'].toDouble() ?? 0.0,
      subTotal: RxDouble(json['sub_total'].toDouble() ?? 0.0),
    );
  }
}

class OrderSummmaryModel {
  final Product product;
  final List<AddonModel> addons;
  final Restaurant restaurant;
  final List<ProductQuantityModel> productQuantity;
  OrderSummmaryModel({
    required this.product,
    required this.addons,
    required this.restaurant,
    required this.productQuantity,
  });

  factory OrderSummmaryModel.fromJson(Map<String, dynamic> json) {
    return OrderSummmaryModel(
      product: Product.fromJson(json['product']),
      addons: List<AddonModel>.from(
          json['addons'].map((addon) => AddonModel.fromJson(addon))),
      restaurant: Restaurant.fromJson(json['restaurant']),
      productQuantity: List<ProductQuantityModel>.from(json['productQuatity']
          .map((quantity) => ProductQuantityModel.fromJson(quantity))),
    );
  }
}

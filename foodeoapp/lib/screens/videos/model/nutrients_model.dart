class NutrientsModel {
  List<Allergens> allergens;
  List<Nutrients> nutrients;

  NutrientsModel({required this.allergens, required this.nutrients});

  Map<String, dynamic> tojson() => {
        'allergens': allergens,
        "nutrients": nutrients,
      };

  factory NutrientsModel.fromjson(Map<String, dynamic> json) {
    List<Allergens> allergensList = List<Allergens>.from(
      json['allergens'].map((category) => Allergens.fromjson(category)),
    );

    List<Nutrients> nutrientslist = List<Nutrients>.from(
      json['nutrients'].map((product) => Nutrients.fromjson(product)),
    );
    return NutrientsModel(allergens: allergensList, nutrients: nutrientslist);
  }
}

class Allergens {
  final int? id;
  final int productId;
  final String allergens;
  final String image;

  Allergens({
    this.id,
    required this.image,
    required this.productId,
    required this.allergens,
  });

  Map<String, dynamic> tojson() =>
      {'id': id, "product_id": productId, 'reviews': allergens, 'image': image};

  factory Allergens.fromjson(Map<String, dynamic> json) {
    return Allergens(
        id: json['id'],
        image: json['icon'] ??
            'https://media.istockphoto.com/id/1138669979/photo/exotic-indian-and-asian-gourmet-food-ingredients.jpg?s=2048x2048&w=is&k=20&c=-OucXyQcFGn8HZobUuHxGH7--5StT3kqVBJp3lkzL_w=',
        productId: json["product_id"] ?? 0,
        allergens: json['allergens'] ?? "");
  }
}

class Nutrients {
  final int? id;
  final int productId;
  final String nutritional_values;
  final String? nutritional_names;

  Nutrients({
    this.id,
    this.nutritional_names,
    required this.productId,
    required this.nutritional_values,
  });

  Map<String, dynamic> tojson() => {
        'id': id,
        "product_id": productId,
        'nutritional_values': nutritional_values,
        'nutritional_names': nutritional_names
      };

  factory Nutrients.fromjson(Map<String, dynamic> json) {
    return Nutrients(
        id: json['id'] ?? 0,
        nutritional_names: json['nutritional_names'] ?? "",
        productId: json["product_id"] ?? 0,
        nutritional_values: json['nutritional_values'] ?? '');
  }
}

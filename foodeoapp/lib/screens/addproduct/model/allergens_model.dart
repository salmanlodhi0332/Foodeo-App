class AllergensModel {
  final int? id;
  final String allergens;
  final String image;

  AllergensModel({
    this.id,
    required this.image,
    required this.allergens,
  });

  Map<String, dynamic> tojson() =>
      {'id': id, 'allergens': allergens, 'icon': image};

  factory AllergensModel.fromjson(Map<String, dynamic> json) {
    return AllergensModel(
        id: json['id'],
        image: json['icon'] ??
            "https://p.kindpng.com/picc/s/150-1504273_peanut-png-peanuts-clipart-transparent-png.png",
        allergens: json['allergens'] ?? "");
  }
}

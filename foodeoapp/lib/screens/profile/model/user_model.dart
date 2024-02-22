class UserModel {
  final String token;
  final int id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String image;

  UserModel({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'image': image,
    };
  }
}

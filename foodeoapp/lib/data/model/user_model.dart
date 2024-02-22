class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? image;
  final String? phoneNumber;
  final String? role;
  final String? gender;
  final String? lastLogin;
  final String? dateofbrith;
  final String? creationdate;
  final String? updateddate;

  UserModel({
    this.id,
    this.name,
    this.role,
    this.lastLogin,
    this.email,
    this.password,
    this.phoneNumber,
    this.image,
    this.gender,
    this.dateofbrith,
    this.creationdate,
    this.updateddate,
  });

  Map<String, dynamic> tojson() => {
        'id': id,
        'name': name,
        "email": email,
        "password": password,
        'role': role,
        'last_login': lastLogin,
        'phone_number': phoneNumber,
        'image': image,
        'gender': gender,
        'dateofbrith': dateofbrith,
        'creationdate': creationdate,
        'updateddate': updateddate
      };

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json["email"],
        role: json['role'],
        lastLogin: json['last_login'],
        password: json['password'],
        phoneNumber: json['phone_number'],
        creationdate: json['creationdate'],
        dateofbrith: json['dateofbrith'],
        gender: json['gender'],
        updateddate: json['updateddate'],
        image: json['image']);
  }
}

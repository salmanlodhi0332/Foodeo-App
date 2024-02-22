class CommentModel {
  int id;
  String name;
  String image;
  String comment;
  String timeAgo;
  DateTime? createdAt;

  CommentModel({
    required this.id,
    required this.image,
    required this.name,
    required this.comment,
    this.createdAt,
    required this.timeAgo,
    // required this.updatedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      comment: json['comments'] ?? '',
      timeAgo: json['time_ago'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'userPicture': image,
  //     'username': name,
  //     'comment': comment,
  //     'created_at': createdAt.toString(),
  //     // 'updated_at': updatedAt.toIso8601String(),
  //   };
  // }
}

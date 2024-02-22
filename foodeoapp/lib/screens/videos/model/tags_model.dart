class tags_model {
  final int? id;
  final String tags;
  // DateTime createdAt;
  // DateTime updatedAt;

  tags_model({
    this.id,
    required this.tags,
    // required this.createdAt,
    // required this.updatedAt,
  });

  Map<String, dynamic> tojson() => {
        'id': id,
        "tags": tags,
        // 'created_at': createdAt,
        // 'updated_at': updatedAt
      };

  factory tags_model.fromjson(Map<String, dynamic> json) {
    return tags_model(
        id: json['id'],
        tags: json['tags'] == null ? '' : json['tags'],
        // createdAt: json["created_at"] ?? "",
        // updatedAt: json['updated_at'] ?? ""
        );
  }
}

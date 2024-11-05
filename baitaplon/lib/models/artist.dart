class Artist {
  final String id;
  final String name;

  Artist({
    required this.id,
    required this.name,
  });

  // Phương thức từ JSON để khởi tạo đối tượng từ phản hồi JSON
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['_id'] ??
          '', // Sử dụng '_id' nếu MongoDB lưu ObjectID theo cách này
      name: json['name'] ?? '',
    );
  }
}

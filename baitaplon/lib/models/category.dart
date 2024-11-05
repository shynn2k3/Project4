class Category {
  final String id;
  final String categoryName;

  Category({
    required this.id,
    required this.categoryName,
  });

  // Phương thức từ JSON để khởi tạo đối tượng từ phản hồi JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ??
          '', // Sử dụng '_id' nếu MongoDB lưu ObjectID theo cách này
      categoryName: json['category_name'] ?? '',
    );
  }
}

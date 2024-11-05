import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart'; // Đảm bảo đường dẫn đúng đến mô hình Category
import '../service/globals.dart';

class CategoryService {
  // Lấy tất cả danh mục
  static Future<List<Category>> getAllCategories() async {
    final url = Uri.parse('$baseURL/api/category');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        print('Failed to load categories: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  // Lấy danh mục theo ID
  static Future<Category?> getCategoryById(String id) async {
    final url = Uri.parse('$baseURL/api/category/detail/$id');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Category.fromJson(data);
      } else {
        print('Failed to load category: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching category by ID: $e');
      return null;
    }
  }

  // Tạo danh mục mới
  static Future<bool> createCategory(String categoryName) async {
    final url = Uri.parse('$baseURL/api/category/create');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'category_name': categoryName}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to create category: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error creating category: $e');
      return false;
    }
  }

  // Cập nhật danh mục
  static Future<Category?> updateCategory(
      String id, String categoryName) async {
    final url = Uri.parse('$baseURL/api/category/update/$id');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'category_name': categoryName}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Category.fromJson(data);
      } else {
        print('Failed to update category: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error updating category: $e');
      return null;
    }
  }

  // Xóa danh mục theo ID
  static Future<bool> deleteCategory(String id) async {
    final url = Uri.parse('$baseURL/api/category/delete/$id');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to delete category: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error deleting category: $e');
      return false;
    }
  }
}

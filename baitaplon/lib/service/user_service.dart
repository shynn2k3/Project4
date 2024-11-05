import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../service/globals.dart'; // Giả sử bạn có file globals chứa URL của backend

class UserService {
  // Đăng ký người dùng
  static Future<User?> registerUser(
      String name, String email, String password) async {
    final url = Uri.parse(
        '$baseURL/api/register'); // Thay đổi URL thành endpoint đăng ký của bạn

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return User.fromJson(data);
      } else {
        print('Registration failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error registering: $e');
      return null;
    }
  }

  // Đăng nhập người dùng
  static Future<User?> loginUser(String email, String password) async {
    final url = Uri.parse(
        '$baseURL/api/login'); // Thay đổi URL thành endpoint đăng nhập của bạn

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return User.fromJson(data);
      } else {
        print('Login failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error logging in: $e');
      return null;
    }
  }

  // Lấy thông tin người dùng theo ID
  static Future<User?> fetchUserById(String userId) async {
    final url = Uri.parse('$baseURL/users/$userId');

    try {
      final response = await http.get(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return User.fromJson(data);
      } else {
        print(
            'Failed to fetch user: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching user by ID: $e');
      return null;
    }
  }
}

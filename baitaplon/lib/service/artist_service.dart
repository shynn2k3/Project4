import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/artist.dart'; // Đảm bảo đường dẫn đúng đến mô hình Artist
import '../service/globals.dart';

class ArtistService {
  // Lấy tất cả nghệ sĩ
  static Future<List<Artist>> getAllArtists() async {
    final url = Uri.parse('$baseURL/api/artist');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Artist.fromJson(json)).toList();
      } else {
        print('Failed to load artists: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching artists: $e');
      return [];
    }
  }

  // Lấy nghệ sĩ theo ID
  static Future<Artist?> getArtistById(String id) async {
    final url = Uri.parse('$baseURL/api/artist/detail/$id');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Artist.fromJson(data);
      } else {
        print('Failed to load artist: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching artist by ID: $e');
      return null;
    }
  }

  // Tạo nghệ sĩ mới
  static Future<bool> createArtist(String name) async {
    final url = Uri.parse('$baseURL/api/artist/create');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to create artist: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error creating artist: $e');
      return false;
    }
  }

  // Xóa nghệ sĩ theo ID
  static Future<bool> deleteArtist(String id) async {
    final url = Uri.parse('$baseURL/api/artist/delete/$id');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to delete artist: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error deleting artist: $e');
      return false;
    }
  }
}

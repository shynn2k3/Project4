import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/song.dart'; // Đảm bảo đường dẫn đúng đến mô hình Song

class SongService {
  final String baseURL =
      'http://localhost:8080/api/songs'; // Cập nhật URL đến backend của bạn

  // Lấy tất cả bài hát
  Future<List<Song>> getAllSongs() async {
    try {
      final response = await http.get(Uri.parse(baseURL));

      if (response.statusCode == 200) {
        final List<dynamic> songJson = json.decode(response.body);
        return songJson.map((json) => Song.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load songs');
      }
    } catch (e) {
      print('Error fetching songs: $e');
      return [];
    }
  }

  // Lấy bài hát theo ID
  Future<Song?> getSongById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseURL/$id'));

      if (response.statusCode == 200) {
        return Song.fromJson(json.decode(response.body));
      } else {
        print('Song not found');
        return null;
      }
    } catch (e) {
      print('Error fetching song by id: $e');
      return null;
    }
  }

  // Tải lên bài hát
  Future<Song?> uploadMusicFile(File musicFile, String name, String lyric,
      String artistId, String categoryId) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseURL/upload'));
      request.fields['name'] = name;
      request.fields['lyric'] = lyric;
      request.fields['artistId'] = artistId;
      request.fields['categoryId'] = categoryId;
      request.files
          .add(await http.MultipartFile.fromPath('music', musicFile.path));

      var response = await request.send();

      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        return Song.fromJson(json.decode(responseBody));
      } else {
        print('Failed to upload song: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading music file: $e');
      return null;
    }
  }

  // Xóa bài hát
  Future<bool> deleteSong(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseURL/delete/$id'));

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to delete song: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error deleting song: $e');
      return false;
    }
  }
}

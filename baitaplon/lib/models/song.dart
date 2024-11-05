import 'package:baitaplon/models/artist.dart';
import 'package:baitaplon/models/category.dart';

class Song {
  final String id;
  final String name;
  final String lyric;
  final String music;
  final Category? category;
  final Artist? artist;

  Song({
    required this.id,
    required this.name,
    required this.lyric,
    required this.music,
    this.category,
    this.artist,
  });

  // Phương thức từ JSON để khởi tạo đối tượng từ phản hồi JSON
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['_id'] ??
          '', // Sử dụng '_id' nếu MongoDB lưu ObjectID theo cách này
      name: json['name'] ?? '',
      lyric: json['lyric'] ?? '',
      music: json['music'] ?? '',
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      artist: json['artist'] != null ? Artist.fromJson(json['artist']) : null,
    );
  }
}

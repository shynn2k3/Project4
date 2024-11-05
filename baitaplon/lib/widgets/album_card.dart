import 'package:baitaplon/views/album_view.dart';
import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final ImageProvider? image; // Đánh dấu là nullable
  final String? label; // Đánh dấu là nullable
  final VoidCallback? onTap; // Sử dụng VoidCallback cho các hàm callback
  final double size;

  const AlbumCard({
    Key? key,
    this.image,
    this.label,
    this.onTap,
    this.size = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(); // Gọi onTap nếu nó không phải là null
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlbumView(
                image: image ??
                    AssetImage(
                        'assets/default_image.png'), // Hình ảnh mặc định nếu image là null
              ),
            ),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image != null // Kiểm tra image không phải là null
              ? Image(
                  image: image!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: size,
                  height: size,
                  color: Colors.grey, // Hoặc một màu khác nếu không có hình ảnh
                ),
          SizedBox(height: 10),
          Text(
            label ?? '', // Cung cấp giá trị mặc định nếu label là null
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

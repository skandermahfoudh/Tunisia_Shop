import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FacebookImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const FacebookImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  State<FacebookImage> createState() => _FacebookImageState();
}

class _FacebookImageState extends State<FacebookImage> {
  Uint8List? imageBytes;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    try {
      final response = await http.get(
        Uri.parse(widget.imageUrl),
        headers: {
          "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          imageBytes = response.bodyBytes;
          isLoading = false;
        });
      } else {
        debugPrint('❌ HTTP error ${response.statusCode}');
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('❌ Exception: $e');
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (hasError || imageBytes == null) {
      return const Icon(Icons.error, size: 48, color: Colors.red);
    } else {
      return Image.memory(
        imageBytes!,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      );
    }
  }
}

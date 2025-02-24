import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key, 
    this.border,
    this.padding,
    this.onPressed,
    this.width, 
    this.height, 
    required this.imageUrl, 
    this.applyImageRadius = true, 
    this.backgroundColor = TColors.light, 
    this.fit = BoxFit.contain, 
    this.isNetworkImage = false, 
    this.borderRadius = TSizes.md, 
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  ImageProvider getImageProvider() {
    if (isNetworkImage) {
      return NetworkImage(imageUrl);
    }
    return AssetImage(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("🔗 Image URL: $imageUrl");
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border, 
          color: backgroundColor, 
          borderRadius: BorderRadius.circular(borderRadius)
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius 
              ? BorderRadius.circular(borderRadius) 
              : BorderRadius.zero, 
          child: isNetworkImage 
              ? CachedNetworkImage(
                  imageUrl: imageUrl, // Use the actual URL from Firebase
                  fit: fit,
                  placeholder: (context, url) => const SizedBox(), // Removed loading indicator
                  errorWidget: (context, url, error) => Image.asset(
                    TImages.productImage1, // Fallback local asset
                    fit: fit,
                  ),
                )
              : Image.asset(
                  imageUrl,
                  fit: fit,
                ),
        ),
      ),
    );
  }
}


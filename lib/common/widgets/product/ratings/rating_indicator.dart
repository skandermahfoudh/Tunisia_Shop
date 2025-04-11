import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';

class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        rating: 4.5,
        itemSize: 20,
        unratedColor: TColors.grey,
        itemBuilder: (_, __) => const Icon(
              Iconsax.star,
              color: Colors.red,
            ));
  }
}

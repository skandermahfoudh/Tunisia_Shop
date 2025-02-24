import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/features/shop/models/products_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TProductImageBox extends StatelessWidget {
  final ProductsModel product;

  const TProductImageBox({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Bar
          const TAppBar(
            showBackArrow: true,
            actions: [
              TCircularIcon(icon: Iconsax.heart, color: Colors.red),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Image inside a box
          Container(
            width: double.infinity,
            height: 250,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: dark ? TColors.darkerGrey : TColors.light,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: TColors.primary,
                width: 1.5,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image.asset(
                TImages.appLogo,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

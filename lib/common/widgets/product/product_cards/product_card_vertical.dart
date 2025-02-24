import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/styles/shadows.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:t_store/features/shop/models/products_model.dart';
import 'package:t_store/features/shop/screens/product_details/product_detail.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({
    super.key,
    required this.product,
    this.showBorder = true,
  });

  final ProductsModel product;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final isZaraProduct = product.title != null; // Check if it's a Zara product

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white
        ),
        child: Column(
          children: [
            /// Thumbnail Section
            Flexible(
              flex: 6,
              child: TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: dark ? TColors.dark : TColors.light,
                child: Stack(
                  children: [
                    // Thumbnail Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(TSizes.productImageRadius),
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
                            color: dark ? TColors.darkerGrey : TColors.light,
                          ),
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
                            color: dark ? TColors.darkerGrey : TColors.light,
                          ),
                          child: const Center(
                            child: Icon(Icons.error_outline, color: TColors.error, size: 40),
                          ),
                        ),
                      ),
                    ),

                    // Price Tag
                    Positioned(
                      top: 12,
                      left: 3,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, 
                          vertical: TSizes.xs
                        ),
                        child: Text(
                          '${product.price} TND',
                          style: Theme.of(context).textTheme.labelLarge!.apply(
                            color: TColors.black
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Details Section
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title (Different for Zara and Barbechli)
                    TProductTitleText(
                      title: isZaraProduct ? product.title! : product.name,
                      smallSize: true,
                      maxLines: 2,
                    ),

                    const SizedBox(height: TSizes.spaceBtwItems / 2),

                    // Availability Tag (Zara Only)
                    if (isZaraProduct && product.availability != null)
                      TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.primary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, 
                          vertical: TSizes.xs
                        ),
                        child: Text(
                          product.availability!,
                          style: Theme.of(context).textTheme.labelSmall!.apply(
                            color: TColors.white
                          ),
                        ),
                      ),

                    // Source Logo (Barbechli Only)
                    if (!isZaraProduct && product.sourceLogo.isNotEmpty)
                      Center(
                        child: SizedBox(
                          height: 20,
                          child: CachedNetworkImage(
                            imageUrl: product.sourceLogo,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const SizedBox.shrink(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error_outline,
                              color: TColors.error,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/curved_edges/curved_edges_widgets.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/models/products_model.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/bottom_add_to_card_widget.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:t_store/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductsModel product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image with White Background
            Container(
              width: double.infinity,
              color: Colors.white,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                height: 300,
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.error_outline,
                    color: TColors.error,
                    size: 40,
                  ),
                ),
              ),
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
                top: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  const TRatingAndShare(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // Title, Subcategory, Price, Source Logo
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Product Name
                            Text(
                               product.title != null ? product.title! : product.name, // Use title for Zara products, name for others
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: TSizes.sm),

                            /// Subcategory
                            if (product.subCategory.isNotEmpty)
                              Text(
                                product.subCategory,
                                style:
                                    Theme.of(context).textTheme.labelMedium,
                              ),
                            const SizedBox(height: TSizes.sm),

                            /// Product Color (For Zara products)
                            if (product.productColor != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Color:    ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Text(
                                        product.productColor!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              color: TColors.grey,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: TSizes.sm),
                                ],
                              ),

                            /// Price & Discount (Only if both oldPrice and discount are not null)
                            Row(
                              children: [
                                Text(
                                  '${product.price} TND',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: TColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(width: TSizes.sm),
                                if (product.oldPrice != null &&
                                    product.discount != null) ...[
                                  Text(
                                    '${product.oldPrice} TND',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: TColors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: TSizes.sm),
                                    child: Text(
                                      '${product.discount}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            color: TColors.error,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),

                      /// Source Logo (Optimized image size and quality)
                      if (product.sourceLogo.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.sourceLogo,
                            height: 100, // Adjust the size as per your design
                            width: 100,  // Adjust the size as per your design
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high, // Improve image rendering
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error, size: 24),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// External Product Link Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final url = product.title != null 
                            ? product.productUrl  // For Zara products
                            : product.sourceUrl;  // For Barbechli products
                        _launchURL(url);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary,
                        padding: const EdgeInsets.all(TSizes.md),
                        side: const BorderSide(color: TColors.primary),
                      ),
                      child: Text(
                        product.title != null ? 'View on Zara' : 'See More Details',  // Different text based on product type
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: TColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                        title: 'Reviews(199)',
                        showActionButton: false,
                      ),
                      IconButton(
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                        onPressed: () =>
                            Get.to(() => const ProductReviewsCreen()),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

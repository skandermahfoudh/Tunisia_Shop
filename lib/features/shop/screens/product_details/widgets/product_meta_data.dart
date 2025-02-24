import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/features/shop/models/products_model.dart';

class TProductMetaData extends StatelessWidget {
  final ProductsModel product;

  const TProductMetaData({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            const SizedBox(width: TSizes.spaceBtwItems),

            /// Price
            Text(
              '${product.price.toStringAsFixed(2)} Dt',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            TProductPriceText(
              price: product.price.toString(),
              isLarge: true
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Title
        TProductTitleText(title: product.name),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Stock Status
        // Row(
        //   children: [
        //     const TProductTitleText(title: 'Status'),
        //     const SizedBox(width: TSizes.spaceBtwItems),
        //     Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
        //   ],
        // ),

        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Brand
        // Row(
        //   children: [
        //     TCircularImage(
        //       image: TImages.peakLogo,
        //       width: 32,
        //       height: 32,
           
        //     ),
        //     TBrandTitleWithVerifiedIcon(
        //       title: 'PEAK Sports Tunisie	',
        //       brandTextSize: TextSizes.medium,
        //     ),
        //   ],
        // )
      ],
    );
  }
}

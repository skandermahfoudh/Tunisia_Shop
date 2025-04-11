import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/chips/choice_chip.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        // -- Selected Attribute Pricing & Description
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkGrey : TColors.lightGrey,
          child: Column(
            children: [
              // -- Title , Price and Stock Status
              Row(
                children: [
                  const TSectionHeading(title: 'Variation'),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(
                              title: 'Price : ', smallSize: true),
                          // Actual Price
                          Text('100 Dt',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      decoration: TextDecoration.lineThrough)),

                          const SizedBox(width: TSizes.spaceBtwItems),

                          // Sale Price
                          const TProductTitleText(title: '80'),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              // -- Variation Description
              const TProductTitleText(
                  title:
                      'This is the description of the Product and it can go upto max 4 lines. ',
                  smallSize: true,
                  maxLines: 4),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // -- Product Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Colors', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(
                    text: 'Green', selected: true, onSelected: (value) {}),
                TChoiceChip(
                    text: 'Red', selected: false, onSelected: (value) {}),
                TChoiceChip(
                    text: 'Yellow', selected: false, onSelected: (value) {}),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Sizes'),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(
                    text: 'Eu 34', selected: false, onSelected: (value) {}),
                TChoiceChip(
                    text: 'Eu 36', selected: true, onSelected: (value) {}),
                TChoiceChip(
                    text: 'Eu 38', selected: false, onSelected: (value) {}),
              ],
            )
          ],
        )
      ],
    );
  }
}

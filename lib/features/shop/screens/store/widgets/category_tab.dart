import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/brands/brand_showcase.dart';
import 'package:t_store/common/widgets/layout/grid_layout.dart';
import 'package:t_store/common/widgets/product/product_cards/product_card_vertical.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/features/shop/controllers/products_controller.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final clothesController = Get.find<ProductsController>();

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // -- Brands
              const TBrandShowcase(
                images: [
                  TImages.productImage3,
                  TImages.productImage2,
                  TImages.productImage1,
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // -- Products
              TSectionHeading(
                  title: "You Might Like",
                  showActionButton: true,
                  onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Obx(
              //   () => TGridLayout(
              //     itemCount: clothesController.clothes.length,
              //     itemBuilder: (_, index) => TProductCardVertical(
              //       product: clothesController.clothes[index],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

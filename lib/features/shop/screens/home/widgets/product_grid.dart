import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/product/product_cards/product_card_vertical.dart';
import 'package:t_store/features/shop/controllers/products_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TProductGrid extends StatelessWidget {
  const TProductGrid({
    super.key,
    required this.itemCount,
    this.showBorder = true,
  });

  final int itemCount;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductsController>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Obx(
      () {
        final allProducts = [
         
        ];

        return Container(
          height: screenHeight * 0.8, // Set a fixed height
          child: GridView.builder(
            itemCount: allProducts.length,
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: TSizes.gridViewSpacing,
              crossAxisSpacing: TSizes.gridViewSpacing,
              mainAxisExtent: 288,
            ),
            itemBuilder: (_, index) {
              final product = allProducts[index];
              return TProductCardVertical(
                product: product,
                showBorder: showBorder,
              );
            },
          ),
        );
      },
    );
  }
}

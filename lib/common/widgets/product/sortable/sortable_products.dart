import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/layout/grid_layout.dart';
import 'package:t_store/common/widgets/product/product_cards/product_card_vertical.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/features/shop/controllers/products_controller.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final productsController = Get.find<ProductsController>();
    
    return Column(
      children: [
        // -- DropDown
        DropdownButtonFormField(
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity'
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: (value) {},
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
    
        // -- Products
        // Obx(
        //   () => TGridLayout(
        //     itemCount: productsController.clothes.length,
        //     itemBuilder: (_, index) => TProductCardVertical(
        //       product: productsController.clothes[index],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}


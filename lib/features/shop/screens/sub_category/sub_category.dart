import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/controllers/category_controller.dart';
import 'package:t_store/common/widgets/product/product_cards/product_card_vertical.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;

  const CategoryProductsScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();

    // Trigger fetch if products are not already loaded
    if (controller.products.isEmpty && !controller.isLoading.value) {
      controller.getCategoryProducts(category);
    }

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Changed to 2 cards per row
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 300, // Fixed height for each card
                ),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return SizedBox(
                    height: 300, // Match the mainAxisExtent
                    child: TProductCardVertical(
                      product: product,
                      showBorder: true,
                    ),
                  );
                },
              ),
      ),
    );
  }
}

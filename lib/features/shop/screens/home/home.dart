import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/layout/grid_layout.dart';
import 'package:t_store/common/widgets/product/product_cards/product_card_vertical.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/models/products_model.dart';
import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_categories.dart';
import 'package:t_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:t_store/features/shop/services/apify_api_service.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/features/shop/controllers/products_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsController = Get.put(ProductsController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -- Header Section
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  const THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSearchContainer(text: 'Search in Store'),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(title: 'Popular Categories', onPressed: () {}),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        const THomeCatgeories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            // -- Body Content
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(banners: [
                    TImages.promoBanner1,
                    TImages.promoBanner2,
                    TImages.promoBanner3,
                  ]),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  FutureBuilder<List<dynamic>>(
                    future: ApiService.fetchApifyData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No products found'));
                      }

                      final allProducts = snapshot.data!;

                      // Group by category and take 3 products per category
                      final Map<String, List<Map<String, dynamic>>> grouped = {};
                      for (var product in allProducts) {
                        final category = product['subcategory'] ?? 'Other';
                        if (!grouped.containsKey(category)) {
                          grouped[category] = [];
                        }
                        if (grouped[category]!.length < 3) {
                          grouped[category]!.add(product);
                        }
                      }

                      final limitedProducts = grouped.values.expand((list) => list).toList();

                      return TGridLayout(
                        title: "All Products",
                        onPressed: () => Get.to(() => const AllProductsScreen()),
                        itemCount: limitedProducts.length,
                        itemBuilder: (_, index) {
                          final product = limitedProducts[index];

                          final productModel = ProductsModel(
                            id: product['id'] ?? '',
                            name: product['marketplace_listing_title'] ?? '',
                            imageUrl: product['primary_listing_photo']['photo_image_url'] ?? '',
                            price: double.tryParse(product['listing_price']['amount'] ?? '0') ?? 0.0,
                            location: product['location']['reverse_geocode']['city_page']['display_name'] ?? '',
                            listingUrl: product['listingUrl'] ?? '',
                            productUrl: product['productUrl'] ?? '',
                            sourceLogo: product['sourceLogo'] ?? '',
                            sourceUrl: product['sourceUrl'] ?? '',
                            subCategory: product['subcategory'] ?? '',
                          );

                          return TProductCardVertical(product: productModel);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

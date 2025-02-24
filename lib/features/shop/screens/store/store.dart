import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/appbar/tabbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/common/widgets/layout/grid_layout.dart';
import 'package:t_store/common/widgets/product/cart/cart_menu_icon.dart';
import 'package:t_store/common/widgets/product/product_cards/product_card_vertical.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:t_store/features/shop/controllers/products_controller.dart';
import 'package:t_store/features/shop/screens/store/widgets/category_tab.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductsController>();

    return Obx(() {
      // Get current subcategories based on selected brand
      final subcategories = controller.currentBrand.value == 'MYTEK'
          ? controller.mytekSubcategories
          : controller.currentBrand.value == 'TUNISIANET'
              ? controller.tunisianetSubcategories
              : controller.currentBrand.value == 'ZARA' // Add explicit ZARA check
                  ? controller.zaraSubcategories
                  : []; // Provide empty list as fallback

      return DefaultTabController(
        length: subcategories.length + 1, // +1 for "All" tab
        child: Scaffold(
          appBar: TAppBar(
            title:
                Text('Store', style: Theme.of(context).textTheme.headlineMedium),
            actions: [
              TCartCounterIcon(
                onPressed: () {},
                iconColor: Colors.white,
              ),
            ],
          ),
          body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: THelperFunctions.isDarkMode(context)
                      ? TColors.dark
                      : TColors.white,
                  expandedHeight: 440,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        //--Search Bar
                        const SizedBox(height: TSizes.spaceBtwItems),
                        const TSearchContainer(
                            text: 'Search In Store',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        //--Featured Brands
                        TSectionHeading(
                          title: 'Featured Brands',
                          onPressed: () {},
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                        TGridLayout(
                            itemCount: 4,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              // Define brand data based on index
                              final brands = [
                                {
                                  'image': TImages.zaraLogo,
                                  'title': 'ZARA',
                                  'products':
                                      '${controller.zaraHommeProducts.length}'
                                },
                                {
                                  'image': TImages.mytekLogo,
                                  'title': 'MYTEK',
                                  'products': '${controller.mytekProducts.length}'
                                },
                                {
                                  'image': TImages.tunisianetLogo,
                                  'title': 'Tunisia Net',
                                  'products':  '${controller.tunisianetProducts.length}'
                                },
                                {
                                  'image': TImages.existLogo,
                                  'title': 'Exist',
                                  'products': '150'
                                },
                              ];

                              final brand = brands[index];

                              return GestureDetector(
                                onTap: () async {
                                  // Show loading dialog for all brands
                                  Get.dialog(
                                    const Center(
                                        child: CircularProgressIndicator()),
                                    barrierDismissible: false,
                                  );

                                  try {
                                    if (brand['title'] == 'MYTEK') {
                                      await controller.loadMytekProducts();
                                      controller.currentBrand.value = 'MYTEK';
                                    } else if (brand['title'] == 'Tunisia Net') {
                                      await controller.loadTunisianetProducts();
                                      controller.currentBrand.value =
                                          'TUNISIANET';
                                    } else if (brand['title'] == 'ZARA') {
                                      await controller.loadZaraProducts();
                                      controller.currentBrand.value = 'ZARA';
                                    }
                                  } catch (e) {
                                    print('❌ Error loading products: $e');
                                  } finally {
                                    Get.back(); // Close loading dialog
                                  }

                                  // Force rebuild of tabs
                                  Future.delayed(
                                      const Duration(milliseconds: 100), () {
                                    if (context.mounted) {
                                      DefaultTabController.of(context)
                                          .animateTo(0);
                                    }
                                  });
                                },
                                child: TRoundedContainer(
                                  padding: const EdgeInsets.all(TSizes.sm),
                                  showBorder: true,
                                  backgroundColor: Colors.transparent,
                                  child: Row(
                                    children: [
                                      /// -- Brand Logo
                                      Flexible(
                                        child: TCircularImage(
                                          isNetworkImage: false,
                                          image: brand['image']!,
                                        ),
                                      ),
                                      const SizedBox(
                                          width: TSizes.spaceBtwItems / 2),

                                      /// -- Brand Details
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TBrandTitleWithVerifiedIcon(
                                                title: brand['title']!,
                                                brandTextSize: TextSizes.large),
                                            Text(
                                              '${brand['products']} products',
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),

                  /// Tabs ---
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: TTabBar(
                      tabs: [
                        const Tab(child: Text('All')),
                        ...subcategories.map((category) =>
                            Tab(child: Text(category))).toList(),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                // All Products Tab
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        Obx(() {
                          if (controller.isLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final products = switch (controller.currentBrand.value) {
                            'MYTEK' => controller.mytekProducts,
                            'TUNISIANET' => controller.tunisianetProducts,
                            _ => controller.zaraHommeProducts,
                          };

                          return TGridLayout(
                            itemCount: products.length,
                            itemBuilder: (_, index) => TProductCardVertical(
                              product: products[index],
                              showBorder: true,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                // Subcategory Tabs
                ...subcategories.map((subCategory) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        Obx(() {
                          if (controller.isLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final products = switch (controller.currentBrand.value) {
                            'MYTEK' => controller.mytekProducts
                                .where((p) => p.subCategory == subCategory)
                                .toList(),
                            'TUNISIANET' => controller.tunisianetProducts
                                .where((p) => p.subCategory == subCategory)
                                .toList(),
                            _ => controller.zaraHommeProducts
                                .where((p) => p.subCategory == subCategory)
                                .toList(),
                          };

                          if (products.isEmpty) {
                            return Center(
                              child: Text(
                                'No products in $subCategory',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          }

                          return TGridLayout(
                            itemCount: products.length,
                            itemBuilder: (_, index) => TProductCardVertical(
                              product: products[index],
                              showBorder: true,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                )).toList(),
              ],
            ),
          ),
        ),
      );
    });
  }
}

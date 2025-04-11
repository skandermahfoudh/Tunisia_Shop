import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/layout/grid_layout.dart';
import 'package:t_store/common/widgets/product/product_cards/product_card_vertical.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_categories.dart';
import 'package:t_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [

                  // -- AppBar -- 
                  const THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // -- SearchBar --
                  const TSearchContainer(text: 'Search in Store'),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // -- Categories --
                  Padding(
                    padding: const EdgeInsets.only(left : TSizes.defaultSpace), 
                    child: Column(
                      children: [

                        // -- Heading
                        TSectionHeading(title: 'Popular Categories', onPressed: (){}),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // -- Categories
                        const THomeCatgeories(),
                        

                      ],
                    ),
                  ),
                   const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            //Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [

                  //-- Promo Slider -- 
                  const TPromoSlider(banners: [TImages.promoBanner1, TImages.promoBanner2, TImages.promoBanner3]),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //-- Popular Products --
                  TGridLayout(
                    title: "Popular Products",
                    onPressed: () => Get.to(() => const AllProductsScreen()),
                    itemCount: 2,
                    itemBuilder: (_, index) => const TProductCardVertical(),
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



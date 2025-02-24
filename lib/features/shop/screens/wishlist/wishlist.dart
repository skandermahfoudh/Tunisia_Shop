import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/common/widgets/layout/grid_layout.dart';
import 'package:t_store/common/widgets/product/product_cards/product_card_vertical.dart';
import 'package:t_store/features/shop/screens/home/home.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/features/shop/controllers/wishlist_controller.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();

    return Scaffold(
      appBar: TAppBar(
        title: Text('Wishlist', 
            style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(
              icon: Iconsax.add, 
              onPressed: () => Get.to(const HomeScreen())),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                () => wishlistController.wishlist.isEmpty
                    ? const Center(
                        child: Text('Your wishlist is empty'),
                      )
                    : TGridLayout(
                        itemCount: wishlistController.wishlist.length,
                        itemBuilder: (_, index) => TProductCardVertical(
                          product: wishlistController.wishlist[index],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

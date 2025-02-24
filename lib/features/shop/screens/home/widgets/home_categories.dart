import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:t_store/features/shop/controllers/category_controller.dart';
import 'package:t_store/features/shop/screens/sub_category/sub_category.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class THomeCatgeories extends StatelessWidget {
  const THomeCatgeories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return SizedBox(
      height: 100,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          TVerticalImageText(
            image: TImages.clothIcon,
            title: 'Clothes',
            onTap: () async {
              await categoryController.getCategoryProducts('Clothes');
              Get.to(() => const CategoryProductsScreen(category: 'Clothes'));
            },
          ),
          TVerticalImageText(
            image: TImages.informatique,
            title: 'Informatique',
            onTap: () async {
              await categoryController.getCategoryProducts('Informatique');
              Get.to(() => const CategoryProductsScreen(category: 'Informatique'));
            },
          ),
          TVerticalImageText(
            image: TImages.auto_moto,
            title: 'Auto Moto',
            onTap: () async {
              await categoryController.getCategoryProducts('Auto Moto');
              Get.to(() => const CategoryProductsScreen(category: 'Auto_Moto'));
            },
          ),
          TVerticalImageText(
            image: TImages.sport,
            title: 'Sport',
            onTap: () async {
              await categoryController.getCategoryProducts('Sports');
              Get.to(() => const CategoryProductsScreen(category: 'Sports'));
            },
          ),
          TVerticalImageText(
            image: TImages.entertainment,
            title: 'Gaming',
            onTap: () async {
              await categoryController.getCategoryProducts('Gaming');
              Get.to(() => const CategoryProductsScreen(category: 'Gaming'));
            },
          ),
          TVerticalImageText(
            image: TImages.smartphone,
            title: 'Téléphone',
            onTap: () async {
              await categoryController.getCategoryProducts('Téléphone');
              Get.to(() => const CategoryProductsScreen(category: 'Téléphones'));
            },
          ),
          TVerticalImageText(
            image: TImages.multimedia,
            title: 'Multimédia',
            onTap: () async {
              await categoryController.getCategoryProducts('Multimédia');
              Get.to(() => const CategoryProductsScreen(category: 'Multimédia'));
            },
          ),
        ],
      ),
    );
  }
}

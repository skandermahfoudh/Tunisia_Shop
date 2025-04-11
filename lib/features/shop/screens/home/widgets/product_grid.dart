import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/product/product_cards/product_card_vertical.dart';
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
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
        mainAxisExtent: 288,
      ),
      itemBuilder: (_, index) => const TProductCardVertical(),
    );
  }
}

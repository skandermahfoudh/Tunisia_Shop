import 'package:flutter/material.dart';
import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import '../../../utils/constants/sizes.dart';

class TGridLayout extends StatelessWidget {
  const TGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 288,
    this.title,
    this.showActionButton = true,
    this.onPressed,
    this.buttonTitle = 'View All',
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;
  final String? title;
  final bool showActionButton;
  final String buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title!, style: Theme.of(context).textTheme.headlineSmall),
              if (showActionButton)
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AllProductsScreen()),
                  ), 
                  child: Text(buttonTitle)
                ),
            ],
          ),
        GridView.builder(
          itemCount: itemCount,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: mainAxisExtent,
            mainAxisSpacing: TSizes.gridViewSpacing,
            crossAxisSpacing: TSizes.gridViewSpacing,
          ),
          itemBuilder: itemBuilder,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.white,
    this.backgroundColor = TColors.white,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular Image
            SizedBox(
              width: 65,
              height: 65,
              child: TCircularImage(
                image: image,
                fit: BoxFit.contain,
                padding: TSizes.borderRadiusSm,
                isNetworkImage: false,
                backgroundColor: backgroundColor,
                overlayColor: TColors.dark
              ),
            ),

            // Text
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Container(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center, // Center align the text
              ),
            ),
          ],
        ),
      ),
    );
  }
}

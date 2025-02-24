import 'package:get/get.dart';
import '../models/products_model.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  RxList<ProductsModel> wishlist = <ProductsModel>[].obs;

  void toggleWishlist(ProductsModel product) {
    if (isInWishlist(product)) {
      wishlist.remove(product);
    } else {
      wishlist.add(product);
    }
  }

  bool isInWishlist(ProductsModel product) {
    return wishlist.contains(product);
  }
}
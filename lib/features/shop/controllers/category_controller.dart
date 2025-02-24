import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/products_model.dart';

class CategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<ProductsModel> products = <ProductsModel>[].obs;
  RxBool isLoading = false.obs;

  Future<void> getCategoryProducts(String categoryName) async {
    try {
      isLoading.value = true;
      products.clear();

      print('Fetching products for $categoryName...');

      // Fetch products under the category
      final productsSnapshot = await _firestore
          .collection('Categories')
          .doc(categoryName)
          .collection('Products')
          .get();  // Directly fetching from the 'Products' subcollection

      print('Found ${productsSnapshot.docs.length} products in $categoryName');

      // Map the product documents to your model
      final categoryProducts = productsSnapshot.docs
          .map((doc) {
            final productData = doc.data() as Map<String, dynamic>;
            // Using the ProductsModel.fromMap constructor to map data
            return ProductsModel.fromMap(productData);
          })
          .toList();

      // Set all products to the list
      products.value = categoryProducts;
      print('✅ Total products loaded: ${products.length}');

    } catch (e) {
      print('❌ Error fetching products for $categoryName: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

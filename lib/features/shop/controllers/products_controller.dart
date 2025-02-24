import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/products_model.dart';

class ProductsController extends GetxController {
  static ProductsController get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  // Observable lists for different product types
  final RxList<ProductsModel> barbechliProducts = <ProductsModel>[].obs;
  final RxList<ProductsModel> zaraHommeProducts = <ProductsModel>[].obs;
  final RxList<ProductsModel> mytekProducts = <ProductsModel>[].obs;
  final RxList<ProductsModel> tunisianetProducts = <ProductsModel>[].obs;
  final RxList<String> zaraSubcategories = <String>[].obs;
  final RxList<String> mytekSubcategories = <String>[].obs;
  final RxList<String> tunisianetSubcategories = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxString currentBrand = 'ZARA'.obs;

  @override
  void onInit() {
    super.onInit();
    loadZaraProducts();
  }

  Future<void> loadZaraProducts() async {
    try {
      isLoading.value = true;
      print('🔄 Starting to load ZARA products...');
      
      final snapshot = await _db
          .collection('Products')
          .doc('zaraHomme')
          .collection('items')
          .get();

      if (snapshot.docs.isNotEmpty) {
        List<ProductsModel> products = snapshot.docs
            .map((doc) {
              final data = doc.data();
              print('Processing ZARA product: ${data['name']} with category: ${data['category']}'); // Changed from subcategory to category
              return ProductsModel.fromJson(data);
            })
            .toList();

        zaraHommeProducts.assignAll(products);
        
        // Extract unique categories and filter out empty ones
        final categories = products
            .map((product) => product.subCategory) // Make sure ProductsModel maps 'category' field to subCategory property
            .where((category) => category != null && category.isNotEmpty)
            .toSet()
            .toList();
        
        print('📑 Found categories before assignment: $categories');
        zaraSubcategories.assignAll(categories);
        print('📊 Assigned ${zaraSubcategories.length} categories to zaraSubcategories');
        
        print('👔 Loaded ${zaraHommeProducts.length} ZARA products');
        print('📑 ZARA categories: ${zaraSubcategories.toList()}');
      } else {
        print('⚠️ No ZARA products found in the snapshot');
      }
    } catch (e) {
      print('❌ Error loading ZARA products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMytekProducts() async {
    try {
      isLoading.value = true;
      print('🔄 Starting to load MYTEK products...');
      
      // Query all categories
      final QuerySnapshot categoriesSnapshot = await _db.collection('Categories').get();
      List<ProductsModel> allMytekProducts = [];
      
      print('📂 Scanning ${categoriesSnapshot.docs.length} categories...');
      
      for (var categoryDoc in categoriesSnapshot.docs) {
        print('🔍 Checking category: ${categoryDoc.id}');
        
        final productsSnapshot = await categoryDoc.reference.collection('Products').get();
        
        final mytekProductsInCategory = productsSnapshot.docs
            .map((doc) => ProductsModel.fromJson(doc.data()))
            .where((product) => 
              product.sourceLogo == 'https://barbechli.tn/prefix/polls/assets/images/logos/logo-mytek.jpg'
            )
            .toList();
        
        if (mytekProductsInCategory.isNotEmpty) {
          print('✅ Found ${mytekProductsInCategory.length} MYTEK products in ${categoryDoc.id}');
          allMytekProducts.addAll(mytekProductsInCategory);
        }
      }
      
      mytekProducts.assignAll(allMytekProducts);
      
      // Extract unique categories from MYTEK products
      final categories = allMytekProducts
          .map((product) => product.subCategory)
          .where((category) => category.isNotEmpty)
          .toSet()
          .toList();
      
      mytekSubcategories.assignAll(categories);
      
      print('🖥️ Total MYTEK products loaded: ${mytekProducts.length}');
      print('📑 Found ${mytekSubcategories.length} categories');
      
      if (mytekProducts.isEmpty) {
        print('⚠️ No MYTEK products found in any category');
      }
      
    } catch (e) {
      print('❌ Error loading MYTEK products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadTunisianetProducts() async {
    try {
      isLoading.value = true;
      print('🔄 Starting to load Tunisianet products...');
      
      // Query all categories
      final QuerySnapshot categoriesSnapshot = await _db.collection('Categories').get();
      List<ProductsModel> allTunisianetProducts = [];
      
      print('📂 Scanning ${categoriesSnapshot.docs.length} categories...');
      
      for (var categoryDoc in categoriesSnapshot.docs) {
        print('🔍 Checking category: ${categoryDoc.id}');
        
        final productsSnapshot = await categoryDoc.reference.collection('Products').get();
        
        final tunisianetProductsInCategory = productsSnapshot.docs
            .map((doc) => ProductsModel.fromJson(doc.data()))
            .where((product) => 
              product.sourceLogo == 'https://barbechli.tn/prefix/polls/assets/images/logos/logo-tunisianet.jpg'
            )
            .toList();
        
        if (tunisianetProductsInCategory.isNotEmpty) {
          print('✅ Found ${tunisianetProductsInCategory.length} Tunisianet products in ${categoryDoc.id}');
          allTunisianetProducts.addAll(tunisianetProductsInCategory);
        }
      }
      
      tunisianetProducts.assignAll(allTunisianetProducts);
      
      // Extract unique categories from Tunisianet products
      final categories = allTunisianetProducts
          .map((product) => product.subCategory)
          .where((category) => category.isNotEmpty)
          .toSet()
          .toList();
      
      tunisianetSubcategories.assignAll(categories);
      
      print('🖥️ Total Tunisianet products loaded: ${tunisianetProducts.length}');
      print('📑 Found ${tunisianetSubcategories.length} categories');
      
    } catch (e) {
      print('❌ Error loading Tunisianet products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method to get products by brand
  List<ProductsModel> getProductsByBrand(String brand) {
    switch (brand.toUpperCase()) {
      case 'MYTEK':
        return mytekProducts;
      case 'ZARA':
        return zaraHommeProducts;
      case 'TUNISIANET':
        return tunisianetProducts;
      default:
        return [];
    }
  }

  // Helper method to get subcategories by brand
  List<String> getSubcategoriesByBrand(String brand) {
    switch (brand.toUpperCase()) {
      case 'MYTEK':
        return mytekSubcategories;
      case 'ZARA':
        return zaraSubcategories;
      case 'TUNISIANET':
        return tunisianetSubcategories;
      default:
        return [];
    }
  }
}

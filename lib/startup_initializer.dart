// utils/startup_initializer.dart

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/features/shop/services/products_service.dart';

class StartupInitializer {
  static final _storage = GetStorage();
  static const _importKey = 'initialDataImported';

  static Future<void> runInitialSetup() async {
    try {
      // Initialize ProductsService
      Get.put(ProductsService());
      
      final productsService = ProductsService.instance;
      final hasData = await productsService.hasExistingData();
      
      if (!hasData) {
        await productsService.importInitialData();
        print('✅ Initial products data imported to Firebase:');
        print('  • Clothes collection created');
        print('  • Shoes collection created');
        print('  • Entertainment collection created');
      } else {
        print('ℹ️ Products data already exists in Firebase');
      }
    } catch (e) {
      print('❌ Error during initial setup: $e');
    }
  }
}

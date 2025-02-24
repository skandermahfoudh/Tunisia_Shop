import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductsService extends GetxService {
  static ProductsService get instance => Get.find();
  
  final _db = FirebaseFirestore.instance;
  final _productsRef = FirebaseFirestore.instance.collection('Products');

  Future<void> importInitialData() async {
    try {
      await _importCategory('clothes');
      await _importCategory('shoes');
      await _importCategory('entertainment');
      await _importCategory('men');
      await _importZaraCategory(); // Add Zara import
    } catch (e) {
      throw 'Failed to import data: $e';
    }
  }

  Future<void> _importCategory(String category) async {
    try {
      final String jsonData = await rootBundle.loadString('lib/datasets/$category.json');
      final List<dynamic> itemsList = json.decode(jsonData);
      
      final batch = _db.batch();
      final categoryRef = _productsRef.doc(category);
      
      // Create category document first
      await categoryRef.set({'name': category});
      
      // Add products as subcollection
      for (var item in itemsList) {
        final docRef = categoryRef.collection('items').doc();
        batch.set(docRef, {
          'id': docRef.id,
          'facebookUrl': item['facebookUrl'],
          'listingUrl': item['listingUrl'],
          'productUrl': item['productUrl'] ?? item['listingUrl'] ?? '', // Added productUrl with fallback
          'photoUrl': item['primary_listing_photo']['photo_image_url'],
          'title': item['marketplace_listing_title'],
          'price': double.parse(item['listing_price']['amount']),
          'location': item['location']['reverse_geocode']['city_page']['display_name'],
          'isFavorite': false,
          'category': category,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      
      await batch.commit();
      print('Successfully imported $category data');
    } catch (e) {
      throw 'Failed to import $category data: $e';
    }
  }

  Future<void> _importZaraCategory() async {
    try {
      final String jsonData = await rootBundle.loadString('lib/datasets/zara_homme.json');
      final List<dynamic> itemsList = json.decode(jsonData);
      
      final batch = _db.batch();
      final categoryRef = _productsRef.doc('zaraHomme');
      
      // Create category document first
      await categoryRef.set({'name': 'zaraHomme'});
      
      // Add products as subcollection
      for (var item in itemsList) {
        final docRef = categoryRef.collection('items').doc();
        batch.set(docRef, {
          'id': docRef.id,
          'title': item['name'] ?? '',
          'price': _formatPrice(item['price']),
          'location': 'Tunisia',
          'imageUrl': _formatImageUrl(item['imageUrl'] ?? ''),
          'productColor': item['productColor'] ?? '',
          'productUrl': item['productUrl'] ?? '', // Added productUrl field
          'availability': item['availability'] ?? 'in_stock',
          'isFavorite': false,
          'category': item['familyName'] ?? '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      
      await batch.commit();
      print('Successfully imported Zara Homme data');
    } catch (e) {
      throw 'Failed to import Zara Homme data: $e';
    }
  }

  double _formatPrice(String price) {
    try {
      return double.parse(price.replaceAll(',00', '').replaceAll(',', '.'));
    } catch (e) {
      return 0.0;
    }
  }

  String _formatImageUrl(String url) {
    return url.replaceAll('{width}', '500');
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getProductsByCategory(String category) async {
    try {
      return await _productsRef
          .doc(category)
          .collection('items')
          .orderBy('createdAt', descending: true)
          .get();
    } catch (e) {
      throw 'Failed to fetch $category: $e';
    }
  }

  Future<void> toggleFavorite(String category, String productId, bool isFavorite) async {
    try {
      await _productsRef
          .doc(category)
          .collection('items')
          .doc(productId)
          .update({'isFavorite': !isFavorite});
    } catch (e) {
      throw 'Failed to update favorite status: $e';
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getFavoritesByCategory(String category) async {
    try {
      return await _productsRef
          .doc(category)
          .collection('items')
          .where('isFavorite', isEqualTo: true)
          .get();
    } catch (e) {
      throw 'Failed to fetch favorites from $category: $e';
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> searchProducts(String category, String query) async {
    try {
      return await _productsRef
          .doc(category)
          .collection('items')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThan: query + 'z')
          .get();
    } catch (e) {
      throw 'Failed to search in $category: $e';
    }
  }

  Future<bool> hasExistingData() async {
    try {
      // Check if any category documents exist in the Products collection
      final snapshot = await _productsRef
          .where(FieldPath.documentId, whereIn: [
            'clothes', 
            'shoes', 
            'entertainment',
            'men',
            'zaraHomme'
          ])
          .get();
      
      // Check if all category documents have items
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          final itemsSnapshot = await _productsRef
              .doc(doc.id)
              .collection('items')
              .limit(1)
              .get();
          
          if (itemsSnapshot.docs.isEmpty) {
            return false;
          }
        }
        return true;
      }
      return false;
    } catch (e) {
      print('Error checking existing data: $e');
      return false;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  // Barbechli scraped attributes
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String? oldPrice;
  final String? discount;
  final String sourceLogo;
  final String sourceUrl;
  final String subCategory;
  final String location;
  final String productUrl;
  final String listingUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Additional Zara-specific attributes
  final String? title;
  final String? productColor;
  final String? availability;

  ProductsModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    this.discount,
    required this.sourceLogo,
    required this.sourceUrl,
    required this.subCategory,
    required this.location,
    required this.productUrl,
    required this.listingUrl,
    this.createdAt,
    this.updatedAt,
    // Add optional Zara fields
    this.title,
    this.productColor,
    this.availability,
  });

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      oldPrice: map['oldPrice'],
      discount: map['discount'],
      sourceLogo: map['sourceLogo'] ?? '',
      sourceUrl: map['sourceUrl'] ?? '',
      subCategory: map['category'] ?? '',
      location: map['location'] ?? '',
      productUrl: map['productUrl'] ?? '',
      listingUrl: map['listingUrl'] ?? '',
      createdAt: map['createdAt']?.toDate(),
      updatedAt: map['updatedAt']?.toDate(),
      // Add Zara fields
      title: map['title'],
      productColor: map['productColor'],
      availability: map['availability'],
    );
  }

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      oldPrice: json['oldPrice'],
      discount: json['discount'],
      sourceLogo: json['sourceLogo'] ?? '',
      sourceUrl: json['sourceUrl'] ?? '',
      subCategory: json['category'] ?? '',
      location: json['location'] ?? '',
      productUrl: json['productUrl'] ?? '',
      listingUrl: json['listingUrl'] ?? '',
      createdAt: json['createdAt'] != null ? (json['createdAt'] as Timestamp).toDate() : null,
      updatedAt: json['updatedAt'] != null ? (json['updatedAt'] as Timestamp).toDate() : null,
      // Add Zara fields
      title: json['title'],
      productColor: json['productColor'],
      availability: json['availability'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'oldPrice': oldPrice,
      'discount': discount,
      'sourceLogo': sourceLogo,
      'sourceUrl': sourceUrl,
      'subcategory': subCategory,
      'location': location,
      'productUrl': productUrl,
      'listingUrl': listingUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      // Add Zara fields
      'title': title,
      'productColor': productColor,
      'availability': availability,
    };
  }
}



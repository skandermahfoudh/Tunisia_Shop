// import 'package:cloud_firestore/cloud_firestore.dart';

// class BrandModel {
//   String id;
//   String name;
//   String image;
//   bool? isFeatured;
//   int? productsCount;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   BrandModel({
//     required this.id,
//     required this.name,
//     required this.image,
//     this.isFeatured,
//     this.productsCount,
//     this.createdAt,
//     this.updatedAt,
//   });

//   /// Convert model to JSON structure for storing data in Firebase
//   Map<String, dynamic> toJson() {
//     return {
//       'Id': id,
//       'Name': name,
//       'Image': image,
//       'IsFeatured': isFeatured,
//       'ProductsCount': productsCount,
//       'CreatedAt': createdAt,
//       'UpdatedAt': updatedAt,
//     };
//   }

//   /// Factory method to create a BrandModel from a Firebase document snapshot
//   factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data()!;
//     return BrandModel(
//       id: document.id,
//       name: data['Name'] ?? '',
//       image: data['Image'] ?? '',
//       isFeatured: data['IsFeatured'] ?? false,
//       productsCount: data['ProductsCount'] ?? 0,
//       createdAt: data['CreatedAt'] != null ? (data['CreatedAt'] as Timestamp).toDate() : null,
//       updatedAt: data['UpdatedAt'] != null ? (data['UpdatedAt'] as Timestamp).toDate() : null,
//     );
//   }

//   /// Empty brand model
//   static BrandModel empty() => BrandModel(id: '', name: '', image: '');
// }

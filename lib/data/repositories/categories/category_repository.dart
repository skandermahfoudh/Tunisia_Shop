
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/category_model.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get all categories
  Future<List<CategoryModel>> getAllCategories() async{
    try{
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs.map( (document) => CategoryModel.fromSnapshot(document)).toList();
      return list;
    }on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on TPlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong! Please try again';
    }
  }
  // Get Sub Categories
  
  // Upload Categories to the Cloud Firestore   

}
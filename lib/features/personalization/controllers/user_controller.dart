

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/personalization/models/user_model.dart';
import 'package:t_store/utils/popups/loaders.dart';

class UserController extends GetxController{
  final UserRepository userRepository = UserRepository();
  static UserController get instance => Get.find();

  //save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async{
    try{
      if(userCredentials != null){
        //Convert name to first name and last name
        final nameParts = UserModel.nameParts(userCredentials.user!.displayName?? '');
        final username = UserModel.generateUsername(userCredentials.user!.displayName?? '');

        //Map Data 
        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName:nameParts[0],
          lastName:nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username:username,
          email:userCredentials.user!.email ?? '',
          phoneNumber:userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
        );
        //Save User Data
        await userRepository.saveUserRecord(user);
      }

    }catch(e){
      TLoaders.warningSnackBar(
        title: 'Data not saved' ,
        message: 'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
  }
}
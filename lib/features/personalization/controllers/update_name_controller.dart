import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/personalization/screens/profile/profile.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();
  
  /// Initialize data when screen starts
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch user data and assign it to firstName & lastName controllers
  void initializeNames() {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try{

      // Start Loading
      TFullScreenLoader.openLoadingDialog('We are updating your information...', TImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if(!updateUserNameFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      //Update users's first & last name in the firebase firestore
      Map<String, dynamic> name = {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};
      await userRepository.updateSingleField(name);

      //Update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your name has been updated successfully.');

      //Move to previous screen
      Get.off(() => const ProfileScreen());
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
    
  }
}

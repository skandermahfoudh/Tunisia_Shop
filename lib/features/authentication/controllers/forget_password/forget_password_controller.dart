import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication_repository.dart';
import 'package:t_store/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  //Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //Send Reset Password Email
  sendPasswordResetEmail() async{
    try{
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Processing your request ...', TImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }
      //Form Validation
      if(!forgetPasswordFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Success Screen
      TLoaders.successSnackBar(title: 'Email sent' , message: 'Email Link Sent to Reset your Password'.tr);

      //Redirect
      Get.to( () => ResetPasswordScreen(email: email.text.trim()));

    } catch (e) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap' , message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async{
    try{
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Processing your request ...', TImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }
      
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Success Screen
      TLoaders.successSnackBar(title: 'Email sent' , message: 'Email Link Sent to Reset your Password'.tr);


    } catch (e) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap' , message: e.toString());
    }
  }
}
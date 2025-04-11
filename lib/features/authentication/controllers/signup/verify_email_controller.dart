import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/data/repositories/authentication_repository.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/popups/loaders.dart';

class VerifyEmailController extends GetxController{
  static VerifyEmailController get instance => Get.find();
  // Send Email Whenever Verify Screen appears & Set Timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }
    // Send Email Verification Link
    sendEmailVerification() async {
      try{
        await AuthenticationRepository.instance.sendEmailVerification();
        TLoaders.successSnackBar(title: 'Email Sent!', message: 'Please check your inbox and verify your email');
      }catch(e){
        TLoaders.errorSnackBar(title: 'Snap!', message: e.toString());
      }
    }
    // Set Timer to automatically redirect on Email Verification
    setTimerForAutoRedirect(){
      Timer.periodic(
        const Duration(seconds: 1), 
        (timer) async {
          await FirebaseAuth.instance.currentUser?.reload();
          final user = FirebaseAuth.instance.currentUser;
          if(user?.emailVerified ?? false){
            timer.cancel();
            Get.off(
              () => SuccessScreen (
                image: TImages.staticSuccessIllustration, 
                title: TTexts.yourAccountCreatedTitle, 
                subTitle: TTexts.yourAccountCreatedSubTitle, 
                onPressed: () => AuthenticationRepository.instance.screenRedirect(),
                ),
              );
            
          }
        },
      );
    }

    //Manually Chekc if Email is Verified
    checkEmailVerificationStatus() async{
      final currentUser = FirebaseAuth.instance.currentUser;
      if(currentUser != null && currentUser.emailVerified){
        Get.off(
              () => SuccessScreen (
                image: TImages.staticSuccessIllustration, 
                title: TTexts.yourAccountCreatedTitle, 
                subTitle: TTexts.yourAccountCreatedSubTitle, 
                onPressed: () => AuthenticationRepository.instance.screenRedirect( ),
                ),
              );
      }
    }
  }


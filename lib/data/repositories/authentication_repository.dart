import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:t_store/features/authentication/screens/signup/verify_email.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  // Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }


  // Function to Show Relevant Screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if(user != null){

      //If the user is logged in
      if(user.emailVerified){
        //If the user's email is verified, navigate to the main Bavigation Menu
         Get.offAll( ()=> const NavigationMenu());
      }else{
        //If the user's email is not verified, navigate to the Verify Email Screen 
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
        }
      }else{
        //Local Storage
        deviceStorage.writeIfNull('IsFirstTime', true);
        //Check if it's the first time launching the app
        deviceStorage.read('IsFirstTime') != true 
          ? Get.offAll( () => const LoginScreen()) //Redirect to Login Screen if not the first time
          : Get.offAll( () => const OnBoardingScreen() ); //Redirect to OnBoarding Screen if it's the first time
      }
    }
    //Local Storage
    
    
  

  /* ------------------------ Email & Password sign-in ------------------------ */

  // [EmailAuthentication] - SignIn
  Future<UserCredential> loginWithEmailAndPassword(String email , String password) async {
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong..Please try again';
    }

  }

  // [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(String email , String password) async{
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong..Please try again';
    }
  }

  

  // [EmailVerification] - MAIL VERIFICATION
  Future<void>  sendEmailVerification() async{
    try {
   await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
        throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
        throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
        throw const TFormatException();
    } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
    } catch (e) {
        throw 'Something went wrong. Please try again';
    }
  }



  // [ReAuthenticate] - ReAuthenticate User
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async{
    try{
      // Create a new credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      //ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    }on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong..Please try again';
    }
  }


  // [EmailVerification] - FORGET PASSWORD
   Future<void>  sendPasswordResetEmail(String email) async{
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
        throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
        throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
        throw const TFormatException();
    } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
    } catch (e) {
        throw 'Something went wrong. Please try again';
    }
  }


  /* ------------------------ Federated identity & social sign-in ------------------------ */

  // [GoogleAuthentication] - GOOGLE

  Future<UserCredential?>  signInWithGoogle() async{
    try {

      //Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      //create a new credential
      final credentials = GoogleAuthProvider.credential(
        accessToken : googleAuth?.accessToken,
        idToken : googleAuth?.idToken,
      );

      //Once SignedIn , return the UserCredential
      return await _auth.signInWithCredential(credentials);

      
    } on FirebaseAuthException catch (e) {
        throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
        throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
        throw const TFormatException();
    } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
    } catch (e) {
        if (kDebugMode) print ('Something went: $e');
        return null;
    }
  }

  // [FacebookAuthentication] - FACEBOOK

   /* ------------------------ ./end Federated identity & social sign-in ------------------------ */

   // [LogoutUser] - Valid for any authentication
    Future<void> logout() async {
      try {
        await GoogleSignIn().signOut();
        await FirebaseAuth.instance.signOut();
        Get.offAll(() => const LoginScreen());
      } on FirebaseAuthException catch (e) {
        throw TFirebaseAuthException(e.code).message;
      } on FirebaseException catch (e) {
        throw TFirebaseException(e.code).message;
      } on FormatException catch (_) {
        throw const TFormatException();
      } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
      } catch (e) {
        throw 'Something went wrong. Please try again';
      }
    }

  // [DeleteUser] - Remove user Auth and Firestore Account
    Future<void> deleteAccount() async {
      try {
        await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
        await _auth.currentUser?.delete();
      } on FirebaseAuthException catch (e) {
        throw TFirebaseAuthException(e.code).message;
      } on FirebaseException catch (e) {
        throw TFirebaseException(e.code).message;
      } on FormatException catch (_) {
        throw const TFormatException();
      } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
      } catch (e) {
        throw 'Something went wrong. Please try again';
      }
    }
}

   



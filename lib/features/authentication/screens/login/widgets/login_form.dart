import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/controllers/login/login_controller.dart';
import 'package:t_store/features/authentication/screens/password_configuration/forget_pasword.dart';
import 'package:t_store/features/authentication/screens/signup/signup.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/validators/validation.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key : controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
        children: [
        
          //Email Field
          TextFormField(
            controller : controller.email,
            validator : (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: TTexts.email
            ),
          ),
        
        
          const SizedBox(height: TSizes.spaceBtwInputFields),
        
        
           //Password
          Obx(
            () =>  TextFormField(
              validator:(value) => TValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              expands: false,
              decoration: InputDecoration(
                labelText: TTexts.password, 
                prefixIcon: const Icon(Iconsax.password_check), 
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                  icon :  Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                  )
                ),
            ),
          ),
        
          const SizedBox(height: TSizes.spaceBtwInputFields / 2),
        
          //Remember me and Forgot Password
          Row(
            children: [
            //Remember Me
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx( () => Checkbox(
                  value: controller.rememberMe.value, 
                  onChanged: (value) => 
                  controller.rememberMe.value = !controller.rememberMe.value ),),
                const Text(TTexts.rememberMe),
              ],
            ),
        
            //Forget Password
            TextButton(onPressed: () => Get.to( () => const ForgetPassword()), child: const Text(TTexts.forgetPassword)),
        
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
        
          //Sign in Button
          
          SizedBox(
            width:double.infinity , 
            child: ElevatedButton(onPressed: () => controller.emailAndPasswordSignIn() , child: const Text(TTexts.signIn))),
          const SizedBox(height: TSizes.spaceBtwItems),
          
          //Create Account Button
        
          SizedBox(width:double.infinity , child: OutlinedButton(onPressed: () => Get.to(() => const SignupScreen()), child: const Text(TTexts.createAccount))),
          const SizedBox(height: TSizes.spaceBtwItems),
        
          
        ],
                      ),
      ),
    );
  }
}
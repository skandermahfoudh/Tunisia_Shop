import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:t_store/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/validators/validation.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupformKey,
      child: Column(
      children: [
        Row(
          children: [
    
            Expanded(
              child: TextFormField(
                controller: controller.firstName,
                validator:(value) => TValidator.validateEmptyText('First name', value),
                expands: false,
                decoration: const InputDecoration(
                  labelText: TTexts.firstName,
                  prefixIcon: Icon(Iconsax.user)
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                controller: controller.lastName,
                validator:(value) => TValidator.validateEmptyText('Last name', value),
                expands: false,
                decoration: const InputDecoration(
                  labelText: TTexts.lastName,
                  prefixIcon: Icon(Iconsax.user)
                ),
              ),
            ),
    
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
    
          //Username
          TextFormField(
            validator:(value) => TValidator.validateEmptyText('Username', value),
            controller: controller.username,
            expands: false,
            decoration: const InputDecoration(labelText: TTexts.username, prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          //Email
          TextFormField(
            validator:(value) => TValidator.validateEmptyText('Email', value),
            controller: controller.email,
            expands: false,
            decoration: const InputDecoration(labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          //Phone Number
          TextFormField(
            validator:(value) => TValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            expands: false,
            decoration: const InputDecoration(labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
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
          const SizedBox(height: TSizes.spaceBtwSections),
    
          //Terms and Conditions Checkbox
          const TermsAndConditionsCheckbox(),
          const SizedBox(height: TSizes.spaceBtwSections),
          
          //Sign Up Button
          SizedBox(
            width: double.infinity, 
            child: ElevatedButton(
                onPressed: () => controller.signup() , 
                child: const Text(TTexts.createAccount)
                )
            ),
           ],
        ),
    );
    }
}


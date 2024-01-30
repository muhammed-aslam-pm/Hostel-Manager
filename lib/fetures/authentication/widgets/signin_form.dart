import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/authentication/controllers/register_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/commens/widgets/form_field.dart';
import 'package:hostel_management_app/commens/widgets/login_button.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.controller,
  });

  final SignInController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: TextStyleConstants.dashboardBookingName,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomFormField(
            controller: controller.nameController,
            hitText: "Name",
            validator: (p0) => controller.nameValidation(p0),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: TextStyleConstants.dashboardBookingName,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomFormField(
            controller: controller.emailController,
            hitText: "Email",
            validator: (p0) => controller.emailValidation(p0!),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Enter password",
                style: TextStyleConstants.dashboardBookingName,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomFormField(
            controller: controller.passwordController,
            hitText: "password",
            validator: (p0) => controller.passwordValidation(p0),
            suffixIcon: IconButton(
                onPressed: () {
                  Provider.of<SignInController>(context, listen: false)
                      .togglePassword();
                },
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: ColorConstants.primaryColor.withOpacity(0.5),
                )),
            hideText: controller.hidePassword,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Confirm password",
                style: TextStyleConstants.dashboardBookingName,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomFormField(
            controller: controller.confirmPasswordController,
            hitText: "password",
            validator: (p0) => controller.confirmPasswordValidaton(p0),
            suffixIcon: IconButton(
                onPressed: () {
                  Provider.of<SignInController>(context, listen: false)
                      .togglePassword();
                },
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: ColorConstants.primaryColor.withOpacity(0.5),
                )),
            hideText: controller.hidePassword,
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: LoginButton(
              buttonName: "Sign up",
              onTap: () {
                if (controller.signupFormKey.currentState!.validate()) {
                  Provider.of<SignInController>(context, listen: false)
                      .signin(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/authentication/controllers/login_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/fetures/authentication/screens/fogot_password_screen.dart';
import 'package:hostel_management_app/commens/widgets/login_button.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
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
          TextFormField(
            controller: controller.emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 2,
                  color: ColorConstants.colorGrey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    BorderSide(width: 2, color: ColorConstants.primaryColor),
              ),
              hintText: "Enter your email",
              hintStyle: TextStyle(
                  fontSize: 15,
                  color: ColorConstants.colorGrey,
                  fontWeight: FontWeight.w500),
              suffixIcon: Icon(
                Icons.email_outlined,
                color: ColorConstants.primaryColor.withOpacity(0.5),
              ),
            ),
            validator: (value) =>
                Provider.of<LoginController>(context, listen: false)
                    .emailValidation(value!),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Enter your password",
                style: TextStyleConstants.dashboardBookingName,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: controller.passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    BorderSide(width: 2, color: ColorConstants.colorGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    BorderSide(width: 2, color: ColorConstants.primaryColor),
              ),
              hintText: "Pssword ",
              hintStyle: TextStyle(
                  fontSize: 15,
                  color: ColorConstants.colorGrey,
                  fontWeight: FontWeight.w500),
              suffixIcon: IconButton(
                onPressed: () {
                  Provider.of<LoginController>(context, listen: false)
                      .togglePassword();
                },
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: ColorConstants.primaryColor.withOpacity(0.5),
                ),
              ),
            ),
            obscureText: controller.hidePassword,
            validator: (value) =>
                Provider.of<LoginController>(context, listen: false)
                    .passwordValidation(value),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    activeColor: ColorConstants.primaryColor,
                    value: Provider.of<LoginController>(context)
                        .rememberCredentials,
                    onChanged: (value) {
                      Provider.of<LoginController>(context, listen: false)
                          .remember();
                    },
                  ),
                  const Text("Remember")
                ],
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text("Forgot Password?"))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          LoginButton(
            buttonName: "Login",
            onTap: () {
              if (controller.loginFormKey.currentState!.validate()) {
                Provider.of<LoginController>(context, listen: false)
                    .login(context);
              }
            },
          ),
        ],
      ),
    );
  }
}

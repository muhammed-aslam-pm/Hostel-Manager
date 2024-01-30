import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/authentication/controllers/forgotpassword_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/commens/widgets/login_button.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ForgotPasswordController>(context);
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.forgotPasswordFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Forgot Password?",
                  style: TextStyleConstants.loginTiltle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Don’t Worry ! It occurs . Please enter the email address \nlinked with your account",
                  textAlign: TextAlign.center,
                  style: TextStyleConstants.loginSubtitle1,
                ),
                const SizedBox(
                  height: 70,
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
                      borderSide: BorderSide(
                          width: 2, color: ColorConstants.primaryColor),
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
                  validator: (value) => Provider.of<ForgotPasswordController>(
                          context,
                          listen: false)
                      .emailValidation(
                    value.toString(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginButton(
                  buttonName: "Sent Code",
                  onTap: () {
                    if (controller.forgotPasswordFormKey.currentState!
                        .validate()) {
                      Provider.of<ForgotPasswordController>(context,
                              listen: false)
                          .sendPasswordResetEmail(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

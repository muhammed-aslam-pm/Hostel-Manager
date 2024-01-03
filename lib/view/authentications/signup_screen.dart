import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/authentication/signup_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/login_button.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignupController>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorConstants.primaryWhiteColor,
              ColorConstants.secondaryWhiteColor2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SafeArea(
            child: Container(
              height: MediaQuery.sizeOf(context).height * 85 / 100,
              width: MediaQuery.sizeOf(context).width * 90 / 100,
              decoration: BoxDecoration(
                color: ColorConstants.primaryWhiteColor,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.signupFormKey,
                  child: Column(
                    children: [
                      SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.asset(ImageConstants.appLogo)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Sign up",
                        style: TextStyle(
                            color: ColorConstants.primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyleConstants.dashboardBookingName,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required.";
                          } else {
                            return null;
                          }
                        },
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
                          hintText: "Enter your Name",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: ColorConstants.colorGrey,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
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
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.emailController,
                        validator: (value) {
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value.toString())) {
                            return "Invalied email address.";
                          } else if (value == null || value.isEmpty) {
                            return "Email is required.";
                          } else {
                            return null;
                          }
                        },
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
                      ),
                      SizedBox(
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
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required.";
                          } else if (value.length < 6) {
                            return "Password must be atleast 6 character long";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 2, color: ColorConstants.colorGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 2, color: ColorConstants.primaryColor),
                          ),
                          hintText: "Pssword ",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: ColorConstants.colorGrey,
                              fontWeight: FontWeight.w500),
                          suffixIcon: IconButton(
                              onPressed: () {
                                Provider.of<SignupController>(context,
                                        listen: false)
                                    .togglePassword();
                              },
                              icon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: ColorConstants.primaryColor
                                    .withOpacity(0.5),
                              )),
                        ),
                        obscureText: controller.hidePassword,
                      ),
                      SizedBox(
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
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.confirmPasswordController,
                        validator: (value) {
                          if (controller.passwordController.text != value) {
                            return "Password not correct";
                          }
                          return null;
                        },
                        obscureText: controller.hidePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 2, color: ColorConstants.colorGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 2, color: ColorConstants.primaryColor),
                          ),
                          hintText: "Pssword ",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: ColorConstants.colorGrey,
                              fontWeight: FontWeight.w500),
                          suffixIcon: IconButton(
                              onPressed: () {
                                Provider.of<SignupController>(context,
                                        listen: false)
                                    .togglePassword();
                              },
                              icon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: ColorConstants.primaryColor
                                    .withOpacity(0.5),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: LoginButton(
                          buttonName: "Sign up",
                          onTap: () {
                            Provider.of<SignupController>(context,
                                    listen: false)
                                .signup(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 1,
                            color: ColorConstants.colorGrey,
                            width: MediaQuery.sizeOf(context).width * 35 / 100,
                          ),
                          Text(
                            "or",
                            style: TextStyle(color: ColorConstants.colorGrey),
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.sizeOf(context).width * 35 / 100,
                            color: ColorConstants.colorGrey,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 47,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        color: ColorConstants.secondaryWhiteColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(ImageConstants.googleLogo),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sign in with Google",
                              style: TextStyleConstants.dashboardDate,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

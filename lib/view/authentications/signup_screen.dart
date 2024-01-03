import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/authentication/signup_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/authentications/widgets/signup_form.dart';
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
                    signupForm(controller: controller),
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
    );
  }
}

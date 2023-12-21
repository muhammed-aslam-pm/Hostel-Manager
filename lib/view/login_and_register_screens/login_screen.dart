import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/owner_home_screen/owner_home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorConstants.primaryWhiteColor, // Start color at the top center
              ColorConstants
                  .secondaryWhiteColor2, // End color at the bottom center
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 75.5 / 100,
            width: MediaQuery.sizeOf(context).width * 88.3 / 100,
            decoration: BoxDecoration(
              color: ColorConstants.primaryWhiteColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: Image.asset(ImageConstants.appLogo),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 2.4 / 100,
                  ),
                  Text(
                    "Sign In",
                    style: TextStyleConstants.dashboardVacentRoom1,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 2.4 / 100,
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
                        Image.asset(ImageConstants.appleLogo),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign in with Apple",
                          style: TextStyleConstants.dashboardDate,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
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
                    height: 40,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: ColorConstants.colorGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: ColorConstants.primaryColor),
                      ),
                      labelText: "User Name",
                      labelStyle: TextStyle(
                          fontSize: 15,
                          color: ColorConstants.colorGrey,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: ColorConstants.colorGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: ColorConstants.primaryColor),
                      ),
                      labelText: "Pssword ",
                      labelStyle: TextStyle(
                          fontSize: 15,
                          color: ColorConstants.colorGrey,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OwnerHomeScreen(),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstants.primaryColor,
                          ),
                          height: 40,
                          width: 150,
                          child: Center(
                            child: Text(
                              "Sign In",
                              style: TextStyleConstants.buttonText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

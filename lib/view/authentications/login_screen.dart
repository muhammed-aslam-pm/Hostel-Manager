import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/authentications/signup_screen.dart';
import 'package:hostel_management_app/view/global_widgets/login_button.dart';
import 'package:hostel_management_app/view/authentications/fogot_password_screen.dart';
import 'package:hostel_management_app/view/owner_home_screen/owner_home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome \n Back!",
                  style: TextStyleConstants.loginTiltle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(width: 2, color: ColorConstants.colorGrey),
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
                    suffixIcon: Icon(
                      Icons.lock,
                      color: ColorConstants.primaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            fillColor: MaterialStatePropertyAll(
                                ColorConstants.primaryColor),
                            checkColor: ColorConstants.primaryWhiteColor,
                            value: true,
                            onChanged: (value) {}),
                        Text("Remember")
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text("Forgot Password?"))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                LoginButton(
                    buttonName: "Login",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OwnerHomeScreen(),
                        ),
                      );
                    }),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: Text("Signup Now"))
                  ],
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
                  height: 20,
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
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
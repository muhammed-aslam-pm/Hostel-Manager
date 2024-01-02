import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/login_button.dart';
import 'package:hostel_management_app/view/login_and_register_screens/otp_verification_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Forgot Password?",
                style: TextStyleConstants.loginTiltle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Don’t Worry ! It occurs . Please enter the email address \nlinked with your account",
                textAlign: TextAlign.center,
                style: TextStyleConstants.loginSubtitle1,
              ),
              SizedBox(
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
                height: 20,
              ),
              LoginButton(
                buttonName: "Sent Code",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OTPVerivicationScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

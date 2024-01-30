import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/commens/widgets/login_button.dart';
import 'package:hostel_management_app/fetures/authentication/screens/password_changed_screen.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

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
                "Create new password",
                style: TextStyleConstants.loginTiltle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Your new password must be unique from those\n previously used",
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
                    "Create New Password",
                    style: TextStyleConstants.dashboardBookingName,
                  )
                ],
              ),
              const SizedBox(
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
                  hintText: "Enter your password",
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
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Cofirm Password",
                    style: TextStyleConstants.dashboardBookingName,
                  )
                ],
              ),
              const SizedBox(
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
                  hintText: "Enter your password",
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
              const SizedBox(
                height: 40,
              ),
              LoginButton(
                buttonName: "Save",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasswordChangedScreen(),
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

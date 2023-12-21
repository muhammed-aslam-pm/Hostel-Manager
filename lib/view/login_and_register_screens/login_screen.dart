import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.secondaryWhiteColor,
      body: Center(
        child: Container(
          height: MediaQuery.sizeOf(context).height * 73.5 / 100,
          width: MediaQuery.sizeOf(context).width * 88.3 / 100,
          decoration: BoxDecoration(color: ColorConstants.primaryWhiteColor),
        ),
      ),
    );
  }
}

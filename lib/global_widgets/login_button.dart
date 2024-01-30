import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, this.onTap, required this.buttonName});
  final void Function()? onTap;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorConstants.primaryColor,
        ),
        height: 45,
        width: double.infinity,
        child: Center(
          child: Text(
            buttonName,
            style: TextStyleConstants.buttonText,
          ),
        ),
      ),
    );
  }
}

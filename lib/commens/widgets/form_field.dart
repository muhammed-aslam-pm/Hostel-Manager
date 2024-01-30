import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      required this.controller,
      this.hitText,
      this.hideText = false,
      this.suffixIcon,
      this.validator,
      this.labelText});

  final TextEditingController controller;
  final String? hitText;
  final String? labelText;
  final bool hideText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: ColorConstants.colorGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(width: 2, color: ColorConstants.primaryColor),
          ),
          hintText: hitText,
          label: Text(labelText ?? ""),
          hintStyle: TextStyle(
              fontSize: 15,
              color: ColorConstants.colorGrey,
              fontWeight: FontWeight.w500),
          suffixIcon: suffixIcon),
      obscureText: hideText,
    );
  }
}

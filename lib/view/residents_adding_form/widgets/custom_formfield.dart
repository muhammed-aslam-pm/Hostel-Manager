import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.controller,
    this.suffixWidget,
    this.isExpanded = false,
    this.validator,
  });
  final TextEditingController controller;
  final Widget? suffixWidget;
  final bool isExpanded;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isExpanded ? 100 : 50,
      child: TextFormField(
        expands: isExpanded,
        validator: validator,
        maxLines: isExpanded ? null : 1,
        controller: controller,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(width: 1.5, color: ColorConstants.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(width: 2, color: ColorConstants.primaryColor),
            ),
            suffixIcon: suffixWidget),
      ),
    );
  }
}

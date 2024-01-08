import 'package:flutter/material.dart';

class Validators with ChangeNotifier {
  emailValidation(String value) {
    if (value == null || value.isEmpty) {
      return "Email is required.";
    } else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
      return "Enter a valid email address.";
    } else {
      return null;
    }
  }

  passwordValidation(String value) {
    if (value == null || value.isEmpty) {
      return "Password is required.";
    } else if (value.length < 6) {
      return "Password must be atleast 6 character long";
    } else {
      return null;
    }
  }
}

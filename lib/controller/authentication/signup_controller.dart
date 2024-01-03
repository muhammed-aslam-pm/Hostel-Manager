import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_management_app/controller/connection_checker/connection_checher.dart';

class SignupController with ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool hidePassword = true;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final ConnectionChecker connection = ConnectionChecker();

  signup(context) async {
    try {
      if (signupFormKey.currentState!.validate()) return;

      final isConnected = await connection.isConnected();

      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }
    } on PlatformException catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Somthing went wrong")));
    } finally {}
  }

  togglePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  nameValidation(value) {
    if (value == null || value.isEmpty) {
      return "Name is required.";
    } else {
      return null;
    }
  }

  emailValidation(value) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.toString())) {
      return "Invalied email address.";
    } else if (value == null || value.isEmpty) {
      return "Email is required.";
    } else {
      return null;
    }
  }

  passwordValidation(value) {
    if (value == null || value.isEmpty) {
      return "Password is required.";
    } else if (value.length < 6) {
      return "Password must be atleast 6 character long";
    } else {
      return null;
    }
  }

  confirmPasswordValidaton(value) {
    if (passwordController.text != value) {
      return "Password not correct";
    }
    return null;
  }
}

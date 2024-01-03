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
}

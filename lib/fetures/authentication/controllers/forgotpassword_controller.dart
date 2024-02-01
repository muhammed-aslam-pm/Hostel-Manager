import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/authentication/controllers/authentication_repository.dart';
import 'package:hostel_management_app/commens/functions/connection_checher.dart';
import 'package:hostel_management_app/commens/functions/loading_controller.dart';
import 'package:hostel_management_app/fetures/authentication/screens/password_changed_screen.dart';

class ForgotPasswordController with ChangeNotifier {
  final emailController = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  final loadingController = FullScreenLoader();
  final ConnectionChecker connection = ConnectionChecker();
  final AuthenticationRepository auth = AuthenticationRepository();
//------------------------------------------------------------------------------Sent Reset Email
  sendPasswordResetEmail(context) async {
    try {
      //loading animation
      FullScreenLoader.openLoadinDialog(context);
      final isConnected = await connection.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoadin(context);

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }

      await auth.resetPassword(email: emailController.text.trim());
      FullScreenLoader.stopLoadin(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PasswordChangedScreen(),
          ));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email Lisk Sent to reset your Password")));
    } catch (e) {
      FullScreenLoader.stopLoadin(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("oops ${e.toString()}")));
    }
  }

//------------------------------------------------------------------------------Email validation
  emailValidation(String value) {
    if (value.isEmpty) {
      return "Email is required.";
    } else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
      return "Enter a valid email address.";
    } else {
      return null;
    }
  }
}

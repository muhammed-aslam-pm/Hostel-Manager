import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_management_app/controller/authentication/authentication_repository.dart';
import 'package:hostel_management_app/controller/connection_checker/connection_checher.dart';
import 'package:hostel_management_app/view/authentications/signup_successfull_page.dart';
import 'package:provider/provider.dart';

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
      final isConnected = await connection.isConnected();
      final authProvider =
          Provider.of<AuthenticationRepository>(context, listen: false);

      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }
      String? errorMessage = await authProvider.signUpWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text);
      if (errorMessage == null) {
        // Successful sign-up
        // Navigate to the next screen or perform other actions
      } else {
        // Show error message to the user
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));
      }
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      if (authProvider.userCredential.user?.uid != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpSuccessfullScree(),
          ),
        );
      }
    } on PlatformException catch (e) {
      if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      print(e);
    }
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

  emailValidation(String value) {
    if (value == null || value.isEmpty) {
      return "Email is required.";
    } else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
      return "Enter a valid email address.";
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

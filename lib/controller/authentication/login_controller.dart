import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/connection_checker/connection_checher.dart';
import 'package:hostel_management_app/view/owner_home_screen/owner_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = false;
  bool rememberCredentials = false;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final ConnectionChecker connection = ConnectionChecker();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(BuildContext context) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (rememberCredentials) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', emailController.text.trim());
        prefs.setString('password', passwordController.text.trim());
      }
      if (credential.user?.uid != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OwnerHomeScreen(),
            ));
      }
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

//remember credentials
  remember() {
    rememberCredentials = !rememberCredentials;
    notifyListeners();
  }

//hive password
  togglePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

//email and password validation

  emailValidation(value) {
    if (value == null || value.isEmpty) {
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
}

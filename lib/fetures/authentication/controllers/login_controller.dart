// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/commens/functions/connection_checher.dart';
import 'package:hostel_management_app/commens/functions/loading_controller.dart';
import 'package:hostel_management_app/fetures/profile/screens/account_setup_screen.dart';
import 'package:hostel_management_app/fetures/home/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;

  bool rememberCredentials = false;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final ConnectionChecker connection = ConnectionChecker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final loadingController = FullScreenLoader();
  bool isLoading = false;

  //----------------------------------------------------------------------------remember credentials
  remember() {
    rememberCredentials = !rememberCredentials;
    notifyListeners();
  }

  //----------------------------------------------------------------------------fetch stored credential credential
  fetchStordCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString('email') ?? "";
    passwordController.text = prefs.getString('password') ?? "";
    notifyListeners();
  }

  //----------------------------------------------------------------------------Login

  Future<void> login(BuildContext context) async {
    try {
      // start loading screen
      FullScreenLoader.openLoadinDialog(context);
      print("started");

      // store credentials in local storage

      if (rememberCredentials) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', emailController.text.trim());
        prefs.setString('password', passwordController.text.trim());
      }

      final credential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      //Navigate to home page

      if (credential.user?.uid != null) {
        emailController.clear();
        passwordController.clear();
        final DocumentSnapshot userData = await _firestore
            .collection("Owners")
            .doc(credential.user?.uid)
            .get();
        final bool isFirstTime = await userData['AccountSetupcompleted'];

        if (!isFirstTime) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const AccountSetupScreen(),
              ),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false);
        }
      } else {
        FullScreenLoader.stopLoadin(context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password provided for that user.')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('OOps ${e.code.toString()}')));
      }
      FullScreenLoader.stopLoadin(context);
    }
  }

//------------------------------------------------------------------------------hide password
  togglePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

//------------------------------------------------------------------------------email validation

  emailValidation(String value) {
    if (value.isEmpty) {
      return "Email is required.";
    } else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
      return "Enter a valid email address.";
    } else {
      return null;
    }
  }
//------------------------------------------------------------------------------Password validation

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

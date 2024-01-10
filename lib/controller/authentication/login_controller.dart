import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hostel_management_app/controller/connection_checker/connection_checher.dart';
import 'package:hostel_management_app/controller/loading/loading_controller.dart';
import 'package:hostel_management_app/view/account_setup_screen/account_setup_screen.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final loadingController = FullScreenLoader();

  //remember credentials
  remember() {
    rememberCredentials = !rememberCredentials;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    try {
      // start loading screen

      FullScreenLoader.openLoadinDialog(context);

      final credential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // store credentials in local storage

      if (rememberCredentials) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', emailController.text.trim());
        prefs.setString('password', passwordController.text.trim());
        print(prefs.getString('email'));
        print(prefs.getString('password'));
      }

      //Navigate to home page

      if (credential.user?.uid != null) {
        final DocumentSnapshot userData = await _firestore
            .collection("Owners")
            .doc(credential.user?.uid)
            .get();
        final bool isFirstTime = await userData['AccountSetupcompleted'];
        print(' id first :$isFirstTime');
        if (!isFirstTime) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountSetupScreen(),
              ));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OwnerHomeScreen(),
            ),
          );
        }
      }
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        const ScaffoldMessenger(
            child: SnackBar(content: Text('No user found for that email.')));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        const ScaffoldMessenger(
            child: SnackBar(
                content: Text('Wrong password provided for that user.')));
        print('Wrong password provided for that user.');
      }
    }
  }

//Login with google

  Future<void> loginWuthGoogle(context) async {
    try {
      // start loading screen

      FullScreenLoader.openLoadinDialog(context);

      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      final userCredential = await _auth.signInWithCredential(credential);

      //checkinf if it is a new User
      if (userCredential.user?.uid != null) {
        final DocumentSnapshot userData = await _firestore
            .collection("Owners")
            .doc(userCredential.user?.uid)
            .get();
        final bool isFirstTime = await userData['AccountSetupcompleted'];
        print(' id first :$isFirstTime');
        if (!isFirstTime) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountSetupScreen(),
              ));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OwnerHomeScreen(),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        // return 'The account already exists for that email.';
      }
      // return e.message; // Return error message for other exceptions
    } catch (e) {
      ScaffoldMessenger(
          child: SnackBar(content: Text('Error: ${e.toString()}')));
      // Return generic error message for other exceptions
    }
  }

//hive password
  togglePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

//email and password validation

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
}

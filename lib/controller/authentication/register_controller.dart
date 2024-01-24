import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_management_app/controller/authentication/authentication_repository.dart';
import 'package:hostel_management_app/controller/connection_checker/connection_checher.dart';
import 'package:hostel_management_app/controller/loading/loading_controller.dart';
import 'package:hostel_management_app/view/account_setup_screen/account_setup_screen.dart';
import 'package:hostel_management_app/view/authentications/signup_successfull_page.dart';
import 'package:hostel_management_app/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class SignInController with ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool hidePassword = true;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final ConnectionChecker connection = ConnectionChecker();
  final loadingController = FullScreenLoader();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  signin(context) async {
    try {
      //loading animation
      print("Sign in started");
      // FullScreenLoader.openLoadinDialog(context);
      final isConnected = await connection.isConnected();
      final authProvider =
          Provider.of<AuthenticationRepository>(context, listen: false);

      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }
      String? errorMessage = await authProvider.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text);
      print("Error : $errorMessage");
      // FullScreenLoader.stopLoadin(context);
      if (errorMessage == null) {
        print("uid ${authProvider.userCredential.user?.uid}");
        if (authProvider.userCredential.user?.uid != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpSuccessfullScree(),
            ),
          );
        }
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
    } on PlatformException catch (e) {
      if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      print("error $e");
    } finally {
      // FullScreenLoader.stopLoadin(context);
    }
  }

//google signin

  signInWithGoogle(context) async {
    try {
      //start loading animation
      FullScreenLoader.openLoadinDialog(context);

      //checking internet connection
      final isConnected = await connection.isConnected();

      final authProvider =
          Provider.of<AuthenticationRepository>(context, listen: false);

      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }

      //invoking signup function
      String? errorMessage = await authProvider.signInWithGoogle(context);
      if (errorMessage == null) {
        // Successful sign-up
        // Navigate to the next screen or perform other actions
      } else {
        // Show error message to the user
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));
      }

      //navigating to desired pages
      if (authProvider.userCredentialGoogle.user?.uid != null) {
        final DocumentSnapshot userData = await _firestore
            .collection("Owners")
            .doc(authProvider.userCredentialGoogle.user?.uid)
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
              builder: (context) => const HomeScreen(),
            ),
          );
        }
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
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The  provided is too weak.')));
      print(e);
    }
  }

// hide password
  togglePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

//name form valitator

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

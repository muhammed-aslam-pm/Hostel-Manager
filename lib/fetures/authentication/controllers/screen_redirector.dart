import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:hostel_management_app/fetures/home/screen/home_screen.dart';
import 'package:hostel_management_app/fetures/profile/screens/account_setup_screen.dart';

class ScreenReDirector {
  Widget redirectScreen() {
    final user = FirebaseAuth.instance.currentUser;
    // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    if (user != null) {
      // final DocumentSnapshot userData =
      //     await _firestore.collection("Owners").doc(user.uid).get();
      // final bool isFirstTime = userData['AccountSetupcompleted'];

      // if (!isFirstTime) {
      //   return const AccountSetupScreen();
      // } else {
      return const HomeScreen();
      // }
    } else {
      return const OnBoardingScreen();
    }
  }
}

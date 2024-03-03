// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_repository.dart';
import 'package:hostel_management_app/fetures/profile/models/owner_model.dart';
import 'package:hostel_management_app/fetures/profile/screens/account_setup_screen.dart';
import 'package:hostel_management_app/fetures/home/screen/home_screen.dart';

class AuthenticationRepository extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  late UserCredential userCredentialGoogle;

  final UserRepository user = UserRepository();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//------------------------------------------------------------------------------sign in with Email and Password
  Future<String?> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final newOwner = OwnerModel(
          id: userCredential.user!.uid,
          hostelName: '',
          address: '',
          emailAddress: email,
          mobileNumber: '',
          ownwerName: name,
          profilePictuer: '',
          noOfRooms: 0,
          noOfBeds: 0,
          noOfVacancy: 0,
          isAccountSetupCompleted: false);

      //saving owner data
      await user.saveUserRecords(newOwner);

      return null; // Return null for successful sign-up
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message; // Return error message for other exceptions
    } catch (e) {
      return 'Error: ${e.toString()}'; // Return generic error message for other exceptions
    }
  }

//------------------------------------------------------------------------------signin with google
  Future<String?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      print(userAccount);
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
      print(googleAuth);

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      print(credential);
      userCredentialGoogle = await _auth.signInWithCredential(credential);
      print(userCredential);
      notifyListeners();

      // ignore: unnecessary_null_comparison
      if (userCredentialGoogle != null) {
        final userId = userCredentialGoogle.user!.uid;
        final DocumentSnapshot userData =
            await _firestore.collection("Owners").doc(userId).get();

        if (!userData.exists) {
          // New user, save owner records
          final newOwner = OwnerModel(
            id: userId,
            hostelName: '',
            address: '',
            emailAddress: userCredentialGoogle.user!.email ?? "",
            mobileNumber: userCredentialGoogle.user!.phoneNumber ?? "",
            ownwerName: userCredentialGoogle.user!.displayName ?? "",
            profilePictuer: userCredentialGoogle.user!.photoURL ?? "",
            noOfRooms: 0,
            noOfBeds: 0,
            noOfVacancy: 0,
            isAccountSetupCompleted: false,
          );

          // Save owner data
          await user.saveUserRecords(newOwner);
        }
        final DocumentSnapshot newUserData =
            await _firestore.collection("Owners").doc(userId).get();

        final bool isFirstTime = await newUserData['AccountSetupcompleted'];

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

        // Return null for successful sign-up
        return null;
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        // Return 'The account already exists for that email.'
      }
      return e.message; // Return error message for other exceptions
    } catch (e) {
      print('Error: ${e.toString()}');
      return 'Error: ${e.toString()}'; // Return generic error message for other exceptions
    }
  }

  //----------------------------------------------------------------------------reset password

  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
  //----------------------------------------------------------------------------Delete Account

  Future<void> deleteAccount() async {
    try {
      final curentUser = _auth.currentUser;
      await user.deleteOwnerRecords(curentUser!.uid);
      await _auth.currentUser!.delete();
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}

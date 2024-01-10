import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hostel_management_app/controller/users/owner_repository.dart';
import 'package:hostel_management_app/model/owner_model.dart';

class AuthenticationRepository extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  late UserCredential userCredentialGoogle;
  final OwnerRepository owner = OwnerRepository();

// sign in w
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
          isAccountSetupCompleted: false);

      //saving owner data
      await owner.saveOwnerRecords(newOwner);
      // You might perform additional actions here upon successful sign-up
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

//signin with google
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      userCredentialGoogle = await _auth.signInWithCredential(credential);

      if (userCredentialGoogle != null) {
        final newOwner = OwnerModel(
            id: userCredentialGoogle.user!.uid,
            hostelName: '',
            address: '',
            emailAddress: userCredentialGoogle.user!.email ?? "",
            mobileNumber: userCredentialGoogle.user!.phoneNumber ?? "",
            ownwerName: userCredentialGoogle.user!.displayName ?? "",
            profilePictuer: userCredentialGoogle.user!.photoURL ?? "",
            noOfRooms: 0,
            noOfBeds: 0,
            isAccountSetupCompleted: false);

        // //saving owner data
        await owner.saveOwnerRecords(newOwner);
        // You might perform additional actions here upon successful sign-up
      }

      return null; // Return null for successful sign-up
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        // return 'The account already exists for that email.';
      }
      return e.message; // Return error message for other exceptions
    } catch (e) {
      return 'Error: ${e.toString()}'; // Return generic error message for other exceptions
    }
  }

  //reset password

  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(
          'Error: ${e.toString()}'); // Return generic error message for other exceptions
    }
  }
}

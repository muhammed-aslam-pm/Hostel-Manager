import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_management_app/model/owner_model.dart';

class OwnerRepository with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveOwnerRecords(OwnerModel owner) async {
    try {
      await _db.collection("Owners").doc(owner.id).set(owner.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<OwnerModel?> fetchOwnerRecords() async {
    try {
      final currentUser = await _auth.currentUser;
      final documentSnapshot =
          await _db.collection("Owners").doc(currentUser?.uid).get();

      if (documentSnapshot.exists) {
        return OwnerModel.fromSnapshot(documentSnapshot);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> accountSetup(
      {required String id,
      required String mobileNumber,
      required String hostelName,
      required String profilePictuer,
      required int noOfRooms}) async {
    try {
      await _db.collection("Owners").doc(id).update({
        'HostelName': hostelName,
        'MobileNumber': mobileNumber,
        'ProfilePictuer': profilePictuer,
        'NoOfRooms': noOfRooms,
        'AccountSetupcompleted': true
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateOwnerRecords(OwnerModel user) async {
    try {
      await _db.collection("Owners").doc(user.id).update(user.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteOwnerRecords(String userId) async {
    try {
      await _db.collection("Owners").doc(userId).delete();
    } catch (e) {
      print(e);
    }
  }
}

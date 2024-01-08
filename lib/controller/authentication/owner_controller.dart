import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_management_app/model/owner_model.dart';

class OwnerController with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveOwnerRecords(OwnerModel owner) async {
    try {
      await _db.collection("Owners").doc(owner.id).set(owner.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateOwnerRecords(
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
}

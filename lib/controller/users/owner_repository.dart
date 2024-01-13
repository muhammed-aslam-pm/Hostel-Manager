import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_management_app/model/owner_model.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> accountSetup(Map<String, dynamic> json) async {
    try {
      print("ACC Setup");
      final currentUser = await _auth.currentUser;
      await _db.collection("Owners").doc(currentUser!.uid).update(json);
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

  Future<String?> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
    }
  }
}

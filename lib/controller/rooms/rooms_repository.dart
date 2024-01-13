import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/model/room_model.dart';

class RoomsRepository with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<RoomModel>> fetchData() async {
    try {
      final userId = _auth.currentUser?.uid;

      if (userId == null || userId.isEmpty) {
        throw Exception("Unable to find user information, try again later");
      }

      final result =
          await _db.collection("Owners").doc(userId).collection("Rooms").get();

      final roomModels = result.docs
          .map((documentSnapshot) => RoomModel.fromSnapshot(documentSnapshot))
          .toList();

      return roomModels;
    } catch (e) {
      print("Error: $e");
      // Handle the error appropriately, e.g., log, display a message, etc.
      rethrow; // Re-throwing the exception for higher-level error handling
    }
  }

  addRoom(RoomModel room) async {
    try {
      final userId = await _auth.currentUser!.uid;
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Rooms")
          .add(room.toJson());
    } catch (e) {
      print(e.toString());
    }
  }
}

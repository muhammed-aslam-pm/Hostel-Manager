import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/model/room_model.dart';

class RoomsRepository with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

//fetch Rooms

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

  //fetch single room

  Future<RoomModel?> fetchSingleRoom({required String roomId}) async {
    try {
      final userId = _auth.currentUser?.uid;

      if (userId == null || userId.isEmpty) {
        throw Exception("Unable to find user information, try again later");
      }

      final result = await _db
          .collection("Owners")
          .doc(userId)
          .collection("Rooms")
          .doc(roomId)
          .get();

      if (result.exists) {
        return RoomModel.fromSnapshot(result);
      }
    } catch (e) {
      print("Error: $e");
      // Handle the error appropriately, e.g., log, display a message, etc.
      rethrow; // Re-throwing the exception for higher-level error handling
    }
  }

//Add new Room

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

  //Update room

  Future<void> updadatRoom(RoomModel room) async {
    final userId = await _auth.currentUser!.uid;
    try {
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Rooms")
          .doc(room.id)
          .update(room.toJson());
    } catch (e) {
      print("Somthing went wrong");
    }
  }

  //update single field

  Future<void> updateSingleField(
      {required Map<String, dynamic> json, required String roomId}) async {
    try {
      final currentUser = await _auth.currentUser;
      await _db
          .collection("Owners")
          .doc(currentUser!.uid)
          .collection("Rooms")
          .doc(roomId)
          .update(json);
    } catch (e) {
      print("Somthis went wrong");
      print(e);
    }
  }

  // Delete a room

  Future<void> deleteRoom(String roomId) async {
    try {
      print("room repo");
      final userId = _auth.currentUser!.uid;
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Rooms")
          .doc(roomId)
          .delete();
      print("repo deleted");
    } catch (e) {
      print("somthing went wrong");
    }
  }
}

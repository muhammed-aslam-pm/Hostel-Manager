import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/model/room_model.dart';

class RoomsRepository with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

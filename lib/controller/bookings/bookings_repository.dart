import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/model/booking_model.dart';

class BookingRepository with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

//fetch Bookings

  Future<List<BookingsModel>> fetchData() async {
    try {
      final userId = _auth.currentUser?.uid;

      if (userId == null || userId.isEmpty) {
        throw Exception("Unable to find user information, try again later");
      }

      final result = await _db
          .collection("Owners")
          .doc(userId)
          .collection("Bookings")
          .get();

      final roomModels = result.docs
          .map((documentSnapshot) =>
              BookingsModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
      print("romm models list");

      return roomModels;
    } catch (e) {
      print("Error: $e");
      // Handle the error appropriately, e.g., log, display a message, etc.
      rethrow; // Re-throwing the exception for higher-level error handling
    }
  }

  //Add new Booking

  addBooking(BookingsModel booking) async {
    try {
      final userId = await _auth.currentUser!.uid;
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Bookings")
          .add(booking.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  //Update Booking

  Future<void> updadatBooking(BookingsModel booking) async {
    final userId = await _auth.currentUser!.uid;
    try {
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Bookings")
          .doc(booking.id)
          .update(booking.toJson());
    } catch (e) {
      print("Somthing went wrong");
    }
  }

  //update single field

  Future<void> updadatSingleField(
      {required Map<String, dynamic> json, required String bookingId}) async {
    final userId = await _auth.currentUser!.uid;
    try {
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Bookings")
          .doc(bookingId)
          .update(json);
    } catch (e) {
      print("Somthing went wrong");
    }
  }

  // Delete a booking

  Future<void> deleteBooking(String bookingId) async {
    try {
      final userId = _auth.currentUser!.uid;
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Bookings")
          .doc(bookingId)
          .delete();
    } catch (e) {
      print(e.toString());
      print("somthing went wrong");
    }
  }
}

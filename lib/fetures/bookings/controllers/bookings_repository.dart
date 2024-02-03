// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/bookings/models/booking_model.dart';

class BookingRepository with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

//------------------------------------------------------------------------------fetch Bookings

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

      return roomModels;
    } catch (e) {
      print("Error: $e");

      rethrow;
    }
  }

  //----------------------------------------------------------------------------Add new Booking

  addBooking(BookingsModel booking) async {
    try {
      final userId = _auth.currentUser!.uid;
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Bookings")
          .add(booking.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  //----------------------------------------------------------------------------Update Booking

  Future<void> updadatBooking(BookingsModel booking) async {
    final userId = _auth.currentUser!.uid;
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
  //----------------------------------------------------------------------------update only room no

  Future<void> updateBookingsRoomNo(int oldRoomNo, int newRoomNo) async {
    final userId = _auth.currentUser!.uid;

    try {
      // Query the collection to find all bookings with the oldRoomNo
      QuerySnapshot bookingsSnapshot = await _db
          .collection("Owners")
          .doc(userId)
          .collection("Bookings")
          .where("RoomNo", isEqualTo: oldRoomNo)
          .get();

      // Update the roomNo field for each matching booking
      for (QueryDocumentSnapshot bookingDoc in bookingsSnapshot.docs) {
        await _db
            .collection("Owners")
            .doc(userId)
            .collection("Bookings")
            .doc(bookingDoc.id)
            .update({"RoomNo": newRoomNo});
      }
    } catch (e) {
      print("Something went wrong: $e");
      rethrow;
    }
  }

  //----------------------------------------------------------------------------update single field

  Future<void> updadatSingleField(
      {required Map<String, dynamic> json, required String bookingId}) async {
    final userId = _auth.currentUser!.uid;
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

  //----------------------------------------------------------------------------Delete a booking

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
    }
  }

  //----------------------------------------------------------------------------delete bookiing with room number

  Future<void> deleteBookingsByRoomNo(int roomNo) async {
    try {
      final userId = _auth.currentUser!.uid;

      // Query the collection to find all documents with the specified roomNo
      QuerySnapshot bookingSnapshot = await _db
          .collection("Owners")
          .doc(userId)
          .collection("Bookings")
          .where("RoomNo", isEqualTo: roomNo)
          .get();

      // Delete all matching documents
      for (QueryDocumentSnapshot bookingDoc in bookingSnapshot.docs) {
        await _db
            .collection("Owners")
            .doc(userId)
            .collection("Bookings")
            .doc(bookingDoc.id)
            .delete();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

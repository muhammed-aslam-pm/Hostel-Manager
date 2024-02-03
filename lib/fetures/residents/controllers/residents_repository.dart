// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_management_app/fetures/residents/models/resident_model.dart';

class ResidentsRepository {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //----------------------------------------------------------------------------Fetch Resident Detailes

  Future<List<ResidentModel>> fetchData() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null || userId.isEmpty) {
        throw Exception("Unable to find user information, try again later");
      }

      final result = await _db
          .collection("Owners")
          .doc(userId)
          .collection("Residents")
          .get();

      final residentModel = result.docs
          .map((documentSnapshot) =>
              ResidentModel.fromDocumentSnapshot(documentSnapshot))
          .toList();

      return residentModel;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  //----------------------------------------------------------------------------fetchResident detailes with id

  Future<List<ResidentModel>> fetchResidentsByIds(
      List<String> residentIds) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null || userId.isEmpty) {
        throw Exception("Unable to find user information, try again later");
      }

      final List<ResidentModel> residentModels = [];

      for (String residentId in residentIds) {
        final result = await _db
            .collection("Owners")
            .doc(userId)
            .collection("Residents")
            .doc(residentId)
            .get();

        if (result.exists) {
          final residentModel = ResidentModel.fromDocumentSnapshot(result);
          residentModels.add(residentModel);
        } else {}
      }

      return residentModels;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  // ---------------------------------------------------------------------------Add Residents

  Future<String> addResidents(ResidentModel resident) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null || userId.isEmpty) {
        throw Exception("Unable to find user information, try again later");
      }
      DocumentReference docRef = await _db
          .collection("Owners")
          .doc(userId)
          .collection("Residents")
          .add(resident.toJson());

      // Return the document ID
      return docRef.id;
    } catch (e) {
      print("Error : ${e.toString()}");
      rethrow;
    }
  }
//------------------------------------------------------------------------------delete Resident

  Future<void> deleteResident(String residentId) async {
    try {
      final userId = _auth.currentUser!.uid;
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Residents")
          .doc(residentId)
          .delete();
    } catch (e) {
      print("somthing went wrong $e");
      rethrow;
    }
  }

//------------------------------------------------------------------------------delete list of documents
  Future<void> deleteListOfResidents(List<String> residentIds) async {
    try {
      final userId = _auth.currentUser!.uid;

      for (String residentId in residentIds) {
        await _db
            .collection("Owners")
            .doc(userId)
            .collection("Residents")
            .doc(residentId)
            .delete();
      }
    } catch (e) {
      print("Something went wrong $e");
      rethrow;
    }
  }

// -----------------------------------------------------------------------------delete with room no
  Future<void> deleteResidentsByRoomNo(int roomNo) async {
    try {
      final userId = _auth.currentUser!.uid;

      // Query the collection to find all residents with the specified roomNo
      QuerySnapshot residentsSnapshot = await _db
          .collection("Owners")
          .doc(userId)
          .collection("Residents")
          .where("RoomNo", isEqualTo: roomNo)
          .get();

      // Delete all matching documents
      for (QueryDocumentSnapshot residentDoc in residentsSnapshot.docs) {
        await _db
            .collection("Owners")
            .doc(userId)
            .collection("Residents")
            .doc(residentDoc.id)
            .delete();
      }
    } catch (e) {
      print("Something went wrong: $e");
      rethrow;
    }
  }

  //----------------------------------------------------------------------------update resident Detailes

  Future<void> updateResident(ResidentModel resident) async {
    final userId = _auth.currentUser!.uid;
    try {
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Residents")
          .doc(resident.id)
          .update(resident.toJson());
    } catch (e) {
      print("Somthing went wrong : $e");
      rethrow;
    }
  }

//------------------------------------------------------------------------------update romm no only

  Future<void> updateResidentsRoomNo(int oldRoomNo, int newRoomNo) async {
    final userId = _auth.currentUser!.uid;

    try {
      // Query the collection to find all residents with the oldRoomNo
      QuerySnapshot residentsSnapshot = await _db
          .collection("Owners")
          .doc(userId)
          .collection("Residents")
          .where("RoomNo", isEqualTo: oldRoomNo)
          .get();

      // Update the roomNo field for each matching resident
      for (QueryDocumentSnapshot residentDoc in residentsSnapshot.docs) {
        await _db
            .collection("Owners")
            .doc(userId)
            .collection("Residents")
            .doc(residentDoc.id)
            .update({"RoomNo": newRoomNo});
      }
    } catch (e) {
      print("Something went wrong: $e");
      rethrow;
    }
  }

//------------------------------------------------------------------------------update Singlefield
  Future<void> updateSingleField(String id, Map<String, dynamic> json) async {
    final userId = _auth.currentUser!.uid;

    try {
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Residents")
          .doc(id)
          .update(json);
    } catch (e) {
      print("Something went wrong: $e");
      rethrow;
    }
  }
}

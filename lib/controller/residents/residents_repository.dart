import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_management_app/model/resident_model.dart';

class ResidentsRepository {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //----------------------------------------------Fetch Resident Detailes

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

  // ---------------------------------------------Add Residents

  Future<void> addResidents(ResidentModel resident) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null || userId.isEmpty) {
        throw Exception("Unable to find user information, try again later");
      }
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Residents")
          .add(resident.toJson());
    } catch (e) {
      print("Error : ${e.toString()}");
      rethrow;
    }
  }
//---------------------------------------------------delete Resident

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

  //------------------------------------------------update resident Detailes

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
}

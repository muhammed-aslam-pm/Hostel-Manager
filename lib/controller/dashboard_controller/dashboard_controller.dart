import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardController with ChangeNotifier {
  final currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? userData;
  
  fetchData() async {
    print("Current User $currentUser");
    print("Current User uid ${currentUser!.uid}");
    userData =
        await _firestore.collection("Owners").doc(currentUser!.uid).get();
    print("User Data $userData");
    ownerName = userData!["OwnerName"];
    print("user name $ownerName");
    print("Owner Name ${userData!["OwnerName"]}");
    ChangeNotifier();
  }
  String ownerName = "dd";
}

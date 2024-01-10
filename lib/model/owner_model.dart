import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerModel {
  OwnerModel(
      {required this.id,
      required this.hostelName,
      required this.emailAddress,
      required this.mobileNumber,
      required this.ownwerName,
      required this.profilePictuer,
      required this.noOfRooms,
      required this.isAccountSetupCompleted});
  final String id;
  String ownwerName;
  String hostelName;
  final String emailAddress;
  final String mobileNumber;
  String profilePictuer;
  final int noOfRooms;
  final bool isAccountSetupCompleted;

  Map<String, dynamic> toJson() {
    return {
      'OwnerName': ownwerName,
      'HostelName': hostelName,
      'EmailAddress': emailAddress,
      'MobileNumber': mobileNumber,
      'ProfilePictuer': profilePictuer,
      'NoOfRooms': noOfRooms,
      'AccountSetupcompleted': isAccountSetupCompleted
    };
  }

  // factory model to create owner model from firebase document snapshort

  factory OwnerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return OwnerModel(
          id: document.id,
          hostelName: data['HostelName'] ?? '',
          emailAddress: data['EmailAddress'] ?? '',
          mobileNumber: data['MobileNumber'] ?? '',
          ownwerName: data['OwnerName'] ?? '',
          profilePictuer: data['ProfilePictuer'] ?? '',
          noOfRooms: data['NoOfRooms'] ?? 0,
          isAccountSetupCompleted: data['AccountSetupcompleted'] ?? false);
    } else {
      return OwnerModel.empty();
    }
  }

  static OwnerModel empty() => OwnerModel(
      id: '',
      hostelName: '',
      emailAddress: '',
      mobileNumber: '',
      ownwerName: '',
      profilePictuer: '',
      noOfRooms: 0,
      isAccountSetupCompleted: false);
}

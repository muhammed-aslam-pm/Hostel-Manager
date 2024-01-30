import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerModel {
  OwnerModel(
      {required this.id,
      required this.hostelName,
      required this.address,
      required this.emailAddress,
      required this.mobileNumber,
      required this.ownwerName,
      required this.profilePictuer,
      required this.noOfRooms,
      required this.noOfBeds,
      required this.noOfVacancy,
      required this.isAccountSetupCompleted});
  final String id;
  String ownwerName;
  String hostelName;
  String address;
  final String emailAddress;
  final String mobileNumber;
  String profilePictuer;
  final int noOfRooms;
  final int noOfBeds;
  final int noOfVacancy;
  final bool isAccountSetupCompleted;

  Map<String, dynamic> toJson() {
    return {
      'OwnerName': ownwerName,
      'HostelName': hostelName,
      'Address': hostelName,
      'EmailAddress': emailAddress,
      'MobileNumber': mobileNumber,
      'ProfilePictuer': profilePictuer,
      'NoOfRooms': noOfRooms,
      'NoOfBeds': noOfBeds,
      'NoOfVacancy': noOfVacancy,
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
          address: data['Address'] ?? '',
          emailAddress: data['EmailAddress'] ?? '',
          mobileNumber: data['MobileNumber'] ?? '',
          ownwerName: data['OwnerName'] ?? '',
          profilePictuer: data['ProfilePictuer'] ?? '',
          noOfRooms: data['NoOfRooms'] ?? 0,
          noOfBeds: data['NoOfBeds'] ?? 0,
          noOfVacancy: data['NoOfVacancy'] ?? 0,
          isAccountSetupCompleted: data['AccountSetupcompleted'] ?? false);
    } else {
      return OwnerModel.empty();
    }
  }

  static OwnerModel empty() => OwnerModel(
      id: '',
      hostelName: '',
      address: '',
      emailAddress: '',
      mobileNumber: '',
      ownwerName: '',
      profilePictuer: '',
      noOfRooms: 0,
      noOfBeds: 0,
      noOfVacancy: 0,
      isAccountSetupCompleted: false);
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ResidentModel {
  ResidentModel(
      {this.id,
      required this.name,
      required this.profilePic,
      required this.roomNo,
      required this.roomId,
      required this.phone,
      required this.email,
      required this.address,
      required this.emargencyContact,
      required this.purposOfStay,
      required this.checkIn,
      required this.checkOut,
      required this.nextRentDate,
      required this.isRentPaid});
  final String? id;
  final String profilePic;
  final String name;
  final int roomNo;
  final String roomId;
  final String phone;
  final String email;
  final String address;
  final String emargencyContact;
  final String purposOfStay;
  final DateTime checkIn;
  final DateTime checkOut;
  final DateTime nextRentDate;
  final bool isRentPaid;

  Map<String, dynamic> toJson() {
    return {
      "RoomNo": roomNo,
      "Name": name,
      "ProfilePhoto": profilePic,
      "RoomId": roomId,
      "Phone": phone,
      "Email": email,
      "Address": address,
      "EmargencyContact": emargencyContact,
      "CheckIn": checkIn,
      "CheckOut": checkOut,
      "NextRentDate": nextRentDate,
      "Rentpaid": isRentPaid,
      "Purpose": purposOfStay
    };
  }

  factory ResidentModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ResidentModel(
          id: document.id,
          name: data["Name"] ?? "",
          roomNo: data["RoomNo"] ?? 0,
          roomId: data["RoomId"] ?? "",
          phone: data["Phone"] ?? "",
          email: data["Email"] ?? "",
          address: data["Address"] ?? "",
          emargencyContact: data["EmargencyContact"] ?? "",
          purposOfStay: data["Purpose"] ?? "",
          checkIn: (data['CheckIn'] as Timestamp).toDate(),
          checkOut: (data['CheckOut'] as Timestamp).toDate(),
          nextRentDate: (data['NextRentDate'] as Timestamp).toDate(),
          isRentPaid: data["Rentpaid"] ?? false,
          profilePic: data["ProfilePhoto"] ?? '');
    } else {
      return ResidentModel.empty();
    }
  }

  static ResidentModel empty() => ResidentModel(
      name: '',
      roomNo: 0,
      roomId: '',
      profilePic: '',
      phone: '',
      email: '',
      address: '',
      emargencyContact: '',
      purposOfStay: '',
      checkIn: DateTime(2000),
      checkOut: DateTime(2000),
      nextRentDate: DateTime(2000),
      isRentPaid: false);
}

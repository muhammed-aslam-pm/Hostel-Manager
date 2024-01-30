import 'package:cloud_firestore/cloud_firestore.dart';

class BookingsModel {
  final int roomNO;
  final String name;
  final String phoneNo;
  final DateTime checkIn;
  final bool advancePaid;
  final String roomId;
  String? id;

  BookingsModel(
      {required this.roomNO,
      required this.roomId,
      required this.name,
      required this.phoneNo,
      required this.checkIn,
      required this.advancePaid,
      this.id});

  Map<String, dynamic> toJson() {
    return {
      "RoomNo": roomNO,
      "Name": name,
      "phoneNo": phoneNo,
      "CheckIn": checkIn,
      "AdvancePaid": advancePaid,
      "RoomId": roomId
    };
  }

  factory BookingsModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BookingsModel(
          id: document.id,
          roomNO: data["RoomNo"] ?? 0,
          name: data['Name'] ?? "",
          checkIn: (data['CheckIn'] as Timestamp).toDate(),
          phoneNo: data['phoneNo'] ?? "",
          advancePaid: data['AdvancePaid'] ?? false,
          roomId: data['RoomId'] ?? "");
    } else {
      return BookingsModel.empty();
    }
  }

  static BookingsModel empty() => BookingsModel(
      roomNO: 0,
      name: '',
      phoneNo: '',
      roomId: '',
      checkIn: DateTime(2000),
      advancePaid: false);
}

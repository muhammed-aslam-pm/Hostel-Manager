import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  final int roomNo, capacity, vacancy, rent;
  String? id;
  List<int> facilities;
  List<String> residents;

  RoomModel(
      {required this.roomNo,
      required this.capacity,
      required this.vacancy,
      required this.rent,
      required this.residents,
      required this.facilities,
      this.id});

  Map<String, dynamic> toJson() {
    return {
      "RoomNo": roomNo,
      "Capacity": capacity,
      "Vacancy": vacancy,
      "Rent": rent,
      "Residents": residents,
      "Facilities": facilities
    };
  }

  static RoomModel empty() => RoomModel(
      id: "",
      roomNo: 0,
      capacity: 0,
      vacancy: 0,
      rent: 0,
      facilities: <int>[],
      residents: <String>[]);

  factory RoomModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return RoomModel(
        id: document.id,
        roomNo: data["RoomNo"] ?? 0,
        capacity: data["Capacity"] ?? 0,
        vacancy: data['Vacancy'] ?? 0,
        rent: data['Rent'] ?? 0,
        residents:
            (data["Residents"] as List<dynamic>?)?.cast<String>() ?? <String>[],
        facilities:
            (data["Facilities"] as List<dynamic>?)?.cast<int>() ?? <int>[],
      );
    } else {
      return RoomModel.empty();
    }
  }
}

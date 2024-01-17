import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/connection_checker/connection_checher.dart';
import 'package:hostel_management_app/controller/residents/residents_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_management_app/controller/rooms/rooms_repository.dart';
import 'package:hostel_management_app/model/resident_model.dart';
import 'package:hostel_management_app/model/room_model.dart';

class residentsController with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final roomNoController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final emargencyContactController = TextEditingController();
  final checkInDateController = TextEditingController();
  final checkOutDateController = TextEditingController();

  final ResidentsRepository bookingController = ResidentsRepository();
  final ConnectionChecker connectionController = ConnectionChecker();
  final RoomsRepository roomController = RoomsRepository();
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<ResidentModel> residents = [];
  List<RoomModel> vacantRooms = [];

  bool isEditing = false;

// ------------------------------------------------Fetch Resident detailes
  fetchResidents() async {
    try {
      residents = await bookingController.fetchData();
      residents.sort((a, b) => a.roomNo.compareTo(b.roomNo));
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

//--------------------------------------------------Fetch Vacant Rooms

  fetchVacantRooms() async {
    try {
      List<RoomModel> allRooms = await roomController.fetchData();
      // Filter out vacant rooms (Vacancy > 0)
      vacantRooms = allRooms.where((room) => room.vacancy > 0).toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}

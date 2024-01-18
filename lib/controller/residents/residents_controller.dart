import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/connection_checker/connection_checher.dart';
import 'package:hostel_management_app/controller/residents/residents_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_management_app/controller/rooms/rooms_repository.dart';
import 'package:hostel_management_app/model/resident_model.dart';
import 'package:hostel_management_app/model/room_model.dart';
import 'package:intl/intl.dart';

class ResidentsController with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final purposeController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final emargencyContactController = TextEditingController();
  final checkInDateController = TextEditingController();
  final checkOutDateController = TextEditingController();

  final ResidentsRepository residentsRepository = ResidentsRepository();
  final ConnectionChecker connectionController = ConnectionChecker();
  final RoomsRepository roomController = RoomsRepository();
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<ResidentModel> residents = [];
  List<RoomModel> vacantRooms = [];
  List<String> vacantRoomNoList = [];
  String? selectedRoom = "0";
  String selectedRoomId = "";
  DateTime? checkInDate;
  DateTime? checkOutDate;

  bool isEditing = false;

// ------------------------------------------------Fetch Resident detailes
  fetchResidents() async {
    try {
      residents = await residentsRepository.fetchData();
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
      vacantRooms.sort((a, b) => a.roomNo.compareTo(b.roomNo));
      vacantRoomNoList =
          vacantRooms.map((room) => room.roomNo.toString()).toList();

      selectedRoom = vacantRoomNoList[0].toString();
      selectedRoomId = vacantRooms[0].id!;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

//-------------------------------------------------Add Resident
  addResident(BuildContext context) async {
    try {
      final isConnected = await connectionController.isConnected();
      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }

      final resident = ResidentModel(
          name: nameController.text,
          profilePic: "",
          roomNo: int.parse(selectedRoom!),
          roomId: selectedRoomId,
          phone: phoneNoController.text,
          email: emailController.text,
          address: addressController.text,
          emargencyContact: emargencyContactController.text,
          purposOfStay: purposeController.text,
          checkIn: checkInDate!,
          checkOut: checkOutDate!,
          isRentPaid: true);

      String documentId = await residentsRepository.addResidents(resident);
      if (documentId != null) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("ResidentAdded Successfully"),
        ));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Somthing went wrong"),
        ));
      }

      // Upadte room deatile
      updateRoom(newResidentId: documentId);
      //refresh the page
      // ignore: use_build_context_synchronously
      refreshpage(context);
    } catch (e) {
      print(e.toString());
    }
  }

//------------------------------------------------update room data
  updateRoom({required String newResidentId}) async {
    try {
      final RoomModel? room =
          await roomController.fetchSingleRoom(roomId: selectedRoomId);
      final currentVacancy = room!.vacancy;
      final int vacancy = currentVacancy - 1;
      final currentResidents = room.residents;
      currentResidents.add(newResidentId);
      notifyListeners();

      final Map<String, dynamic> json = {
        "Vacancy": vacancy,
        "Residents": currentResidents
      };
      await roomController.updateSingleField(
          json: json, roomId: selectedRoomId);
    } catch (e) {
      print(e);
    }
  }
//------------------------------------------------refresh page

  refreshpage(BuildContext context) {
    fetchResidents();
    fetchVacantRooms();
    Navigator.pop(context);
    nameController.clear();
    phoneNoController.clear();
    emailController.clear();
    addressController.clear();
    emailController.clear();
    purposeController.clear();
    checkInDateController.clear();
    checkInDateController.clear();
    notifyListeners();
  }

//------------------------------------------------select room
  selectRoom(room) async {
    selectedRoom = room;
    selectedRoomId = findRoomByRoomNo(int.parse(selectedRoom!));
    notifyListeners();
    print(selectedRoom);
    print(selectedRoomId);
  }

//------------------------------------------------fetching RoomId
  String findRoomByRoomNo(int roomNumber) {
    // Find the first room in vacantRooms with the specified room number
    RoomModel? room = vacantRooms.firstWhere(
        (room) => room.roomNo == roomNumber,
        orElse: () => RoomModel.empty());
    return room.id!;
  }

//-------------------------------------------------------------------------Set checkIn date
  void setCheckInDate(DateTime date) {
    if (date != null) {
      checkInDate = date;
      checkInDateController.text = DateFormat('dd/MM/yyy').format(date);
      notifyListeners();
    }
  }

//-------------------------------------------------------------------------Set checkOut date
  void setCheckOutDate(DateTime date) {
    if (date != null) {
      checkOutDate = date;
      checkOutDateController.text = DateFormat('dd/MM/yyy').format(date);
      notifyListeners();
    }
  }

//----------------------------------------------------------------------------Text field validation
  fieldValidation(value) {
    if (value == null || value.isEmpty) {
      return "this Field is required.";
    } else {
      return null;
    }
  }
}

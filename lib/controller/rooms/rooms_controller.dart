import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/connection_checker/connection_checher.dart';
import 'package:hostel_management_app/controller/rooms/rooms_repository.dart';
import 'package:hostel_management_app/controller/users/owner_repository.dart';
import 'package:hostel_management_app/controller/users/user_controller.dart';
import 'package:hostel_management_app/model/room_model.dart';
import 'package:hostel_management_app/utils/image_constants.dart';

class RoomsController with ChangeNotifier {
  List<Map<String, String>> facilitiesList = [
    {"Facility": "AC", "Image": ImageConstants.ACIcon},
    {"Facility": "WiFi", "Image": ImageConstants.wifiIcon},
    {"Facility": "Washingmachine", "Image": ImageConstants.washingMachineIcon},
    {"Facility": "Attached Bathroom", "Image": ImageConstants.bathroomIcon},
  ];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final roomNoController = TextEditingController();
  final capacityController = TextEditingController();
  final rentController = TextEditingController();

  final RoomsRepository controller = RoomsRepository();

  final ConnectionChecker connection = ConnectionChecker();

  final UserController userController = UserController();

  final OwnerRepository userRepoController = OwnerRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  int? oldRoomCapacity;
  int? oldHostelCapacity;
  String? editingRoomId;
  bool isEditing = false;
  List<RoomModel> rooms = [];
  List<int> facilities = [];

  bool ACselected = false;
  bool WMselected = false;
  bool ABselected = false;
  bool WFselected = false;

// fetch room data
  fetchRoomsData() async {
    try {
      rooms = await controller.fetchData();
      rooms.sort((a, b) => a.roomNo.compareTo(b.roomNo));
      notifyListeners();
    } catch (e) {
      print(e.toString());
      // Add a return statement or rethrow the exception
      rethrow; // or return an empty list or handle the error appropriately
    }
  }

// fetch single room
  Future<RoomModel?> fetchRoom(int roomNo) async {
    try {
     return await controller.getRoomByRoomNo(roomNo);
    } catch (e) {
      print(e);
    }
  }

// add new room
  addRoom({required BuildContext context, required int currentCapacity}) async {
    try {
      final isConnected = await connection.isConnected();
      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }

      final roomNo = int.parse(roomNoController.text.trim());

      // Check if the room with the same number already exists
      final existingRoom = await controller.getRoomByRoomNo(roomNo);

      if (existingRoom != null) {
        // Room with the same number already exists, handle accordingly
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Room with the same number already exists")),
        );
        roomNoController.clear();
        capacityController.clear();
        rentController.clear();
        facilities = [];
        ACselected = false;
        WMselected = false;
        ABselected = false;
        WFselected = false;
        notifyListeners();
        return;
      }

      int noOfBeds = currentCapacity + int.parse(capacityController.text);

      await userRepoController.accountSetup({"NoOfBeds": noOfBeds});

      if (ACselected) {
        facilities.add(0);
      }
      if (WFselected) {
        facilities.add(1);
      }
      if (WMselected) {
        facilities.add(2);
      }
      if (ABselected) {
        facilities.add(3);
      }

      final room = RoomModel(
          roomNo: int.parse(roomNoController.text.trim()),
          capacity: int.parse(capacityController.text.trim()),
          vacancy: int.parse(capacityController.text.trim()),
          rent: int.parse(rentController.text.trim()),
          residents: <String>[],
          facilities: facilities);

      //adding room
      await controller.addRoom(room);

      fetchRoomsData();
      roomNoController.clear();
      capacityController.clear();
      rentController.clear();
      facilities = [];
      ACselected = false;
      WMselected = false;
      ABselected = false;
      WFselected = false;
      notifyListeners();
      fetchRoomsData();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Room Added Successfull")));
    } catch (e) {
      print(e.toString());
    }
  }

// Delete a room

  deleteRoom(
      {required String id,
      required BuildContext context,
      required int currentCapacity,
      required int roomCapacity}) async {
    try {
      int noOfBeds = currentCapacity - roomCapacity;
      print("No of Beds :$noOfBeds");

      await userRepoController.accountSetup({"NoOfBeds": noOfBeds});

      await controller.deleteRoom(id);

      Navigator.pop(context);
      fetchRoomsData();
    } catch (e) {
      print(e.toString());
      print("con");
    }
  }

  //Edit a room

  editRoom(BuildContext context) async {
    try {
      if (ACselected) {
        facilities.add(0);
      }
      if (WFselected) {
        facilities.add(1);
      }
      if (WMselected) {
        facilities.add(2);
      }
      if (ABselected) {
        facilities.add(3);
      }

      int noOfBeds = oldHostelCapacity! -
          oldRoomCapacity! +
          int.parse(capacityController.text);

      await userRepoController.accountSetup({"NoOfBeds": noOfBeds});

      final room = RoomModel(
          id: editingRoomId!,
          roomNo: int.parse(roomNoController.text.trim()),
          capacity: int.parse(capacityController.text.trim()),
          vacancy: int.parse(capacityController.text.trim()),
          rent: int.parse(rentController.text.trim()),
          residents: <String>[],
          facilities: facilities);

      await controller.updadatRoom(room);

      fetchRoomsData();
      Navigator.pop(context);
      facilities = [];
      roomNoController.clear();
      rentController.clear();
      capacityController.clear();
      ACselected = false;
      WFselected = false;
      WMselected = false;
      ABselected = false;
      isEditing = false;
      notifyListeners();
    } catch (e) {
      print("Somthing went wrong");
    }
  }

  //edit tap
  onEditTap({required RoomModel room, required int currentCapacity}) {
    isEditing = true;
    roomNoController.text = room.roomNo.toString();
    capacityController.text = room.capacity.toString();
    rentController.text = room.rent.toString();

    if (room.facilities.contains(0)) {
      ACselected = true;
    }
    if (room.facilities.contains(1)) {
      WFselected = true;
    }
    if (room.facilities.contains(2)) {
      WMselected = true;
    }
    if (room.facilities.contains(3)) {
      ABselected = true;
    }
    oldRoomCapacity = room.capacity;
    editingRoomId = room.id;
    oldHostelCapacity = currentCapacity;

    notifyListeners();

    print(isEditing);
  }
//cancel button

  cancel(BuildContext context) {
    roomNoController.clear();
    capacityController.clear();
    rentController.clear();
    facilities = [];
    ACselected = false;
    WMselected = false;
    ABselected = false;
    WFselected = false;
    notifyListeners();
    Navigator.pop(context);
  }

  onSelect(int num) {
    switch (num) {
      case 0:
        {
          ACselected = !ACselected;
          notifyListeners();
        }
        break;
      case 1:
        {
          WFselected = !WFselected;
          notifyListeners();
        }
        break;

      case 2:
        {
          WMselected = !WMselected;
          notifyListeners();
        }
        break;

      case 3:
        {
          ABselected = !ABselected;
          notifyListeners();
        }
        break;
    }
  }

  fieldValidation(value) {
    if (value == null || value.isEmpty) {
      return "this Field is required.";
    } else {
      return null;
    }
  }
}

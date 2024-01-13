import 'package:cloud_firestore/cloud_firestore.dart';
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

  final roomNoController = TextEditingController();
  final capacityController = TextEditingController();
  final rentController = TextEditingController();
  List<int> facilities = [];
  final RoomsRepository controller = RoomsRepository();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ConnectionChecker connection = ConnectionChecker();

  final UserController userController = UserController();
  final OwnerRepository userRepoController = OwnerRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<RoomModel> rooms = [];

  bool ACselected = false;
  bool WMselected = false;
  bool ABselected = false;
  bool WFselected = false;

  CollectionReference roomsCollection = FirebaseFirestore.instance
      .collection('Owners')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Rooms');

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

// add new room
  addRoom({required BuildContext context, required int currentCapacity}) async {
    try {
      final isConnected = await connection.isConnected();
      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }

      int noOfBeds = currentCapacity + int.parse(capacityController.text);

      await userRepoController.accountSetup({"NoOfBeds": noOfBeds});

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
          if (ACselected) {
            facilities.add(0);
            notifyListeners();
          } else {
            facilities.remove(0);
            notifyListeners();
          }
        }
        break;
      case 1:
        {
          WFselected = !WFselected;
          notifyListeners();
          if (WFselected) {
            facilities.add(1);
            notifyListeners();
          } else {
            facilities.remove(2);
            notifyListeners();
          }
        }
        break;

      case 2:
        {
          WMselected = !WMselected;
          notifyListeners();
          if (WMselected) {
            facilities.add(2);
            notifyListeners();
          } else {
            facilities.remove(2);
            notifyListeners();
          }
        }
        break;

      case 3:
        {
          ABselected = !ABselected;
          notifyListeners();
          if (ABselected) {
            facilities.add(3);
            notifyListeners();
          } else {
            facilities.remove(3);
            notifyListeners();
          }
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

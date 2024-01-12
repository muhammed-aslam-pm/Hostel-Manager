import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/connection_checker/connection_checher.dart';
import 'package:hostel_management_app/controller/rooms/rooms_repository.dart';
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

  bool ACselected = false;
  bool WMselected = false;
  bool ABselected = false;
  bool WFselected = false;

  Future<List<RoomModel>> fetchRoomsData() async {
    try {
      print("Function Called");
      final rooms = await controller.fetchData();
      print("rooms $rooms");
      return rooms;
    } catch (e) {
      print(e.toString());
      // Add a return statement or rethrow the exception
      rethrow; // or return an empty list or handle the error appropriately
    }
  }

  addRoom(BuildContext context) async {
    try {
      final isConnected = await connection.isConnected();
      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }

      final room = RoomModel(
          roomNo: int.parse(roomNoController.text.trim()),
          capacity: int.parse(capacityController.text.trim()),
          vacancy: int.parse(capacityController.text.trim()),
          rent: int.parse(rentController.text.trim()),
          residents: <String>[],
          facilities: facilities);
      await controller.addRoom(room);
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
            print(facilities);
          } else {
            facilities.remove(0);
            notifyListeners();
            print(facilities);
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

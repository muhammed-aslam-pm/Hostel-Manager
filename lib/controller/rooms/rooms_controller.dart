import 'package:flutter/material.dart';
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

  bool ACselected = false;
  bool WMselected = false;
  bool ABselected = false;
  bool WFselected = false;

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

  addRoom() async {
    try {
      final room = RoomModel(
          roomNo: int.parse(roomNoController.text.trim()),
          capacity: int.parse(capacityController.text.trim()),
          vacancy: int.parse(capacityController.text.trim()),
          rent: int.parse(rentController.text.trim()),
          residents: [],
          facilities: facilities);
      await controller.addRoom(room);
    } catch (e) {
      print(e.toString());
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

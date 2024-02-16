// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/bookings/controllers/bookings_repository.dart';
import 'package:hostel_management_app/commens/functions/connection_checher.dart';
import 'package:hostel_management_app/fetures/residents/controllers/residents_repository.dart';
import 'package:hostel_management_app/fetures/rooms/controllers/rooms_repository.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_repository.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_controller.dart';
import 'package:hostel_management_app/fetures/profile/models/owner_model.dart';
import 'package:hostel_management_app/fetures/residents/models/resident_model.dart';
import 'package:hostel_management_app/fetures/rooms/models/room_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';

class RoomsController with ChangeNotifier {
  List<Map<String, String>> facilitiesList = [
    {"Facility": "AC", "Image": ImageConstants.acIcon},
    {"Facility": "WiFi", "Image": ImageConstants.wifiIcon},
    {"Facility": "Washingmachine", "Image": ImageConstants.washingMachineIcon},
    {"Facility": "Attached Bathroom", "Image": ImageConstants.bathroomIcon},
  ];
  List<String> filters = [
    "All Rooms",
    "Vacant Rooms",
    "Filled Rooms",
  ];
  String selctedFilter = "All Rooms";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final roomNoController = TextEditingController();
  final capacityController = TextEditingController();
  final rentController = TextEditingController();

  final RoomsRepository controller = RoomsRepository();
  final ConnectionChecker connection = ConnectionChecker();
  final UserController userController = UserController();
  final UserRepository userRepoController = UserRepository();
  final ResidentsRepository residentsRepository = ResidentsRepository();
  final BookingRepository bookingRepository = BookingRepository();

  int? oldRoomCapacity;
  int? oldRoomVacancy;
  int? currentNoOfResidents;
  int? oldRoomNo;
  String? editingRoomId;
  bool isEditing = false;
  bool isResidentLoading = false;
  List<RoomModel> allRooms = [];
  List<RoomModel> rooms = [];
  List<RoomModel> vacantRooms = [];

  List<int> facilities = [];
  List<ResidentModel>? residents = [];
  List<String> oldResidents = [];
  bool isRoomsLoading = false;

  bool acSelected = false;
  bool wmSelected = false;
  bool abSelected = false;
  bool wfSelected = false;

//-------------------------------------------------------------------------------fetch room data
  fetchRoomsData() async {
    try {
      isRoomsLoading = true;

      allRooms = await controller.fetchData();
      allRooms.sort((a, b) => a.roomNo.compareTo(b.roomNo));
      rooms = allRooms;
      isRoomsLoading = false;
    } catch (e) {
      rethrow;
    } finally {
      isRoomsLoading = false;
      notifyListeners();
    }
  }

//----------------------------------------------------------------------------- fetching vacant rooms

  fetchVacantRooms() async {
    try {
      isRoomsLoading = true;
      List<RoomModel> allRooms = await controller.fetchData();
      // Filter out vacant rooms (Vacancy > 0)
      vacantRooms = allRooms.where((room) => room.vacancy > 0).toList();
      vacantRooms.sort((a, b) => a.roomNo.compareTo(b.roomNo));
    } catch (e) {
      rethrow;
    } finally {
      isRoomsLoading = false;
      notifyListeners();
    }
  }

//------------------------------------------------------------------------------fetch single room
  Future<RoomModel?> fetchRoom(int roomNo) async {
    try {
      return await controller.getRoomByRoomNo(roomNo);
    } catch (e) {
      print(e);
    }
    return null;
  }

//------------------------------------------------------------------------------fetchResidents
  fetchResidents(List<String> residentIds) async {
    try {
      isResidentLoading = true;

      residents = await residentsRepository.fetchResidentsByIds(residentIds);
    } catch (e) {
      rethrow;
    } finally {
      isResidentLoading = false;
      notifyListeners();
    }
  }

//------------------------------------------------------------------------------clear residents
  clearResidents() {
    residents!.clear();
  }

//----------------------------------------------------------------------------- add new room
  addRoom(
      {required BuildContext context,
      required int currentCapacity,
      required int currentVacancy}) async {
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
        userController.fetchData();
        facilities = [];
        acSelected = false;
        wmSelected = false;
        abSelected = false;
        wfSelected = false;
        notifyListeners();
        return;
      }

      int noOfBeds = currentCapacity + int.parse(capacityController.text);
      int noOfVacancy = currentVacancy + int.parse(capacityController.text);

      await userRepoController
          .accountSetup({"NoOfBeds": noOfBeds, "NoOfVacancy": noOfVacancy});

      if (acSelected) {
        facilities.add(0);
      }
      if (wfSelected) {
        facilities.add(1);
      }
      if (wmSelected) {
        facilities.add(2);
      }
      if (abSelected) {
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
      acSelected = false;
      wmSelected = false;
      abSelected = false;
      wfSelected = false;
      notifyListeners();
      fetchRoomsData();
      userController.fetchData();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Room Added Successfull")));
    } catch (e) {
      print(e.toString());
    }
  }

//----------------------------------------------------------------------------- Delete a room

  deleteRoom(
      {required BuildContext context,
      required int currentCapacity,
      required int currentVacancy,
      required RoomModel room}) async {
    try {
      final isConnected = await connection.isConnected();
      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }
      int noOfBeds = currentCapacity - room.capacity;
      int vacacy = currentVacancy - room.vacancy;

      await userRepoController
          .accountSetup({"NoOfBeds": noOfBeds, "NoOfVacancy": vacacy});

      if (room.residents.isEmpty) {
        await residentsRepository.deleteListOfResidents(room.residents);
      }

      await bookingRepository.deleteBookingsByRoomNo(room.roomNo);
      await residentsRepository.deleteResidentsByRoomNo(room.roomNo);

      await controller.deleteRoom(room.id!);

      Navigator.pop(context);
      fetchRoomsData();
      userController.fetchData();
    } catch (e) {
      print(e.toString());
    }
  }

  //----------------------------------------------------------------------------Edit a room

  editRoom(BuildContext context) async {
    try {
      if (currentNoOfResidents! > int.parse(capacityController.text.trim())) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "Can't Edit the Room",
                    style: TextStyle(color: ColorConstants.colorRed),
                  ),
                  content: const Text(
                      "This room has more occupents than the given capacity.change the capacity and try again!"),
                  actions: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Try Again"))
                  ],
                ));
        return;
      }
      final isConnected = await connection.isConnected();
      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }
      if (acSelected) {
        facilities.add(0);
      }
      if (wfSelected) {
        facilities.add(1);
      }
      if (wmSelected) {
        facilities.add(2);
      }
      if (abSelected) {
        facilities.add(3);
      }
      final roomVacancy =
          int.parse(capacityController.text.trim()) - currentNoOfResidents!;
      final OwnerModel? owner = await userRepoController.fetchOwnerRecords();
      final currentHostelVacancy = owner!.noOfVacancy;
      final currentHostelbeds = owner.noOfBeds;
      final int hostelVacancy =
          currentHostelVacancy - oldRoomVacancy! + roomVacancy;

      final int noOfBeds = currentHostelbeds -
          oldRoomCapacity! +
          int.parse(capacityController.text);

      await userRepoController
          .accountSetup({"NoOfBeds": noOfBeds, "NoOfVacancy": hostelVacancy});

      if (oldRoomNo != int.parse(roomNoController.text)) {
        await residentsRepository.updateResidentsRoomNo(
            oldRoomNo!, int.parse(roomNoController.text));
        await bookingRepository.updateBookingsRoomNo(
            oldRoomNo!, int.parse(roomNoController.text));
      }

      final room = RoomModel(
          id: editingRoomId!,
          roomNo: int.parse(roomNoController.text.trim()),
          capacity: int.parse(capacityController.text.trim()),
          vacancy: roomVacancy,
          rent: int.parse(rentController.text.trim()),
          residents: oldResidents,
          facilities: facilities);

      await controller.updadatRoom(room);

      fetchRoomsData();
      userController.fetchData();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Room Edited Successfully")));
      Navigator.pop(context);

      facilities = [];
      roomNoController.clear();
      rentController.clear();
      capacityController.clear();
      acSelected = false;
      wfSelected = false;
      wmSelected = false;
      abSelected = false;
      isEditing = false;
      notifyListeners();
      userController.fetchData();
    } catch (e) {
      print("Somthing went wrong : $e");
    }
  }

  //----------------------------------------------------------------------------edit tap
  onEditTap({
    required RoomModel room,
  }) {
    isEditing = true;
    roomNoController.text = room.roomNo.toString();
    capacityController.text = room.capacity.toString();
    rentController.text = room.rent.toString();
    oldRoomNo = room.roomNo;
    oldRoomCapacity = room.capacity;
    oldRoomVacancy = room.vacancy;
    oldResidents = room.residents;
    editingRoomId = room.id;
    currentNoOfResidents = room.residents.length;
    notifyListeners();

    if (room.facilities.contains(0)) {
      acSelected = true;
    }
    if (room.facilities.contains(1)) {
      wfSelected = true;
    }
    if (room.facilities.contains(2)) {
      wmSelected = true;
    }
    if (room.facilities.contains(3)) {
      abSelected = true;
    }

    notifyListeners();
  }
//------------------------------------------------------------------------------cancel button

  cancel(BuildContext context) {
    roomNoController.clear();
    capacityController.clear();
    rentController.clear();
    facilities = [];
    acSelected = false;
    wmSelected = false;
    abSelected = false;
    wfSelected = false;
    notifyListeners();
    Navigator.pop(context);
  }

  onSelect(int num) {
    switch (num) {
      case 0:
        {
          acSelected = !acSelected;
          notifyListeners();
        }
        break;
      case 1:
        {
          wfSelected = !wfSelected;
          notifyListeners();
        }
        break;

      case 2:
        {
          wmSelected = !wmSelected;
          notifyListeners();
        }
        break;

      case 3:
        {
          abSelected = !abSelected;
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

  //----------------------------------------------------------------------------filter Rooms

  selectFilter(filter) async {
    isResidentLoading = true;
    selctedFilter = filter;
    if (selctedFilter == "All Rooms") {
      rooms = allRooms;
    } else if (selctedFilter == "Vacant Rooms") {
      rooms = allRooms.where((room) => room.vacancy > 0).toList();
    } else if (selctedFilter == "Filled Rooms") {
      rooms = allRooms.where((room) => room.vacancy == 0).toList();
    }
    isResidentLoading = false;
    notifyListeners();
  }
}

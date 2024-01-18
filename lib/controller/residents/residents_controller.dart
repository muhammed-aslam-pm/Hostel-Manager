import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/connection_checker/connection_checher.dart';
import 'package:hostel_management_app/controller/residents/residents_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_management_app/controller/rooms/rooms_repository.dart';
import 'package:hostel_management_app/controller/users/owner_repository.dart';
import 'package:hostel_management_app/model/resident_model.dart';
import 'package:hostel_management_app/model/room_model.dart';
import 'package:hostel_management_app/view/residents_adding_form/residents_adding_form.dart';
import 'package:image_picker/image_picker.dart';
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
  final OwnerRepository ownerRepository = OwnerRepository();
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<ResidentModel> residents = [];
  List<RoomModel> vacantRooms = [];
  List<String> vacantRoomNoList = [];
  String? selectedRoom = "0";
  String selectedRoomId = "";
  DateTime? checkInDate;
  DateTime? checkOutDate;
  File? selectedImage;
  String? oldImage;
  String? imageUrl;
  String? editingRoomId;
  String? editingResidentId;
  int? oldRoomNo;
  bool isEditing = false;

// ------------------------------------------------Fetch Resident detailes
  fetchResidents() async {
    try {
      print('fetchData');
      residents = await residentsRepository.fetchData();
      residents.sort((a, b) => a.roomNo.compareTo(b.roomNo));
      print(residents);
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

      if (selectedImage != null) {
        try {
          imageUrl = await ownerRepository.uploadImage(
              'Owners/Images/Residents', XFile(selectedImage!.path));
        } catch (e) {
          print("image : ${e.toString()}");
        }
      }

      final resident = ResidentModel(
          name: nameController.text,
          profilePic: imageUrl ?? "",
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

//------------------------------------------------Edit Resident detaile

  Future<void> editResident(BuildContext context) async {
    try {
      final isConnected = await connectionController.isConnected();
      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }

      if (selectedImage != null) {
        try {
          imageUrl = await ownerRepository.uploadImage(
              'Owners/Images/Residents', XFile(selectedImage!.path));
        } catch (e) {
          print("image : ${e.toString()}");
        }
      }

      final resident = ResidentModel(
          id: editingResidentId,
          name: nameController.text,
          profilePic: imageUrl ?? oldImage ?? "",
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

      if (oldRoomNo == int.parse(selectedRoom!)) {
        await residentsRepository.updateResident(resident);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Resident detailes Edited successfully")));
        refreshpage(context);
      } else {
        try {
          await residentsRepository.updateResident(resident);
          updateRoom(newResidentId: editingResidentId!);
          final RoomModel? room =
              await roomController.fetchSingleRoom(roomId: editingRoomId!);
          final currentVacancy = room!.vacancy;
          final int vacancy = currentVacancy + 1;
          final currentResidents = room.residents;
          currentResidents.remove(editingResidentId);
          notifyListeners();

          final Map<String, dynamic> json = {
            "Vacancy": vacancy,
            "Residents": currentResidents
          };
          await roomController.updateSingleField(
              json: json, roomId: selectedRoomId);

          refreshpage(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Resident detailes Edited successfully")));
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }

//-------------------------------------------------On edit
  onEdit(ResidentModel resident, BuildContext context) async {
    await fetchVacantRooms();
    isEditing = true;
    selectedRoom = resident.roomNo.toString();
    selectedRoomId = resident.roomId;
    selectedImage = null;
    oldImage = resident.profilePic;
    imageUrl = resident.profilePic;
    checkInDate = resident.checkIn;
    checkOutDate = resident.checkOut;
    nameController.text = resident.name;
    phoneNoController.text = resident.phone;
    emailController.text = resident.email;
    addressController.text = resident.address;
    emargencyContactController.text = resident.emargencyContact;
    purposeController.text = resident.purposOfStay;
    checkInDateController.text =
        DateFormat('dd/MM/yyyy').format(resident.checkIn);
    checkOutDateController.text =
        DateFormat('dd/MM/yyyy').format(resident.checkOut);
    editingRoomId = resident.roomId;
    oldRoomNo = resident.roomNo;
    editingResidentId = resident.id;
    notifyListeners();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const ResidentsAddingPage(),
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      useSafeArea: true,
    );
    notifyListeners();
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

//------------------------------------------------select Image
  Future<void> openImagePicker() async {
    try {
      final XFile? pickedImage = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
        notifyListeners();
      } else {
        if (kDebugMode) {
          print('Image not Selected');
        }
      }
    } catch (e) {
      print(e);
    }
  }

//------------------------------------------------refresh page
  refreshpage(BuildContext context) {
    fetchResidents();
    fetchVacantRooms();
    notifyListeners();
    Navigator.pop(context);
    selectedImage = null;
    imageUrl = null;
    checkInDate = null;
    checkOutDate = null;
    selectedImage = null;
    oldImage = null;
    editingRoomId = null;
    editingResidentId = null;
    oldRoomNo = null;
    nameController.clear();
    phoneNoController.clear();
    emailController.clear();
    addressController.clear();
    emailController.clear();
    purposeController.clear();
    checkInDateController.clear();
    checkInDateController.clear();
    isEditing = false;
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

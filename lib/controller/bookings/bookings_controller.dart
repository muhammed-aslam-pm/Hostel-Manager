import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/bookings/bookings_repository.dart';
import 'package:hostel_management_app/controller/connection_checker/connection_checher.dart';
import 'package:hostel_management_app/controller/rooms/rooms_repository.dart';
import 'package:hostel_management_app/model/booking_model.dart';
import 'package:hostel_management_app/model/room_model.dart';

class BookingsController with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final roomNoController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final dateController = TextEditingController();

  final BookingRepository bookingController = BookingRepository();

  final ConnectionChecker connectionController = ConnectionChecker();

  final RoomsRepository roomController = RoomsRepository();

  final FirebaseAuth auth = FirebaseAuth.instance;

  List<BookingsModel> bookings = [];

  List<RoomModel> vacantRooms = [];

  bool isAdvancePaid = true;

  DateTime checkInDate = DateTime.now();

// fetching vacant rooms

  fetchVacantRooms() async {
    try {
      List<RoomModel> allRooms = await roomController.fetchData();

      // Filter out vacant rooms (Vacancy > 0)
      vacantRooms = allRooms.where((room) => room.vacancy > 0).toList();

      notifyListeners();
    } catch (e) {
      print(e.toString());
      // Handle the error appropriately, e.g., log, display a message, etc.
      rethrow; // or return an empty list or handle the error appropriately
    }
  }

  // fetch Bookings data
  fetchBookingsData() async {
    try {
      print("Fetching Bookings ");
      bookings = await bookingController.fetchData();
      bookings.sort((a, b) => a.checkIn.compareTo(b.checkIn));
      print("fetching successfull");
      notifyListeners();
    } catch (e) {
      print(e.toString());
      // Add a return statement or rethrow the exception
      rethrow; // or return an empty list or handle the error appropriately
    }
  }

  //add booking

  addBooking(
      {required BuildContext context,
      required int roomNo,
      required String roomId,
      required int currentVacancy}) async {
    try {
      final isConnected = await connectionController.isConnected();
      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }

      final booking = BookingsModel(
          roomNO: roomNo,
          name: nameController.text,
          phoneNo: phoneNoController.text,
          checkIn: checkInDate,
          advancePaid: isAdvancePaid,
          roomId: roomId);

      await bookingController.addBooking(booking);

      final int vacancy = currentVacancy - 1;
      notifyListeners();

      final Map<String, dynamic> json = {"Vacancy": vacancy};

      await roomController.updateSingleField(json: json, roomId: roomId);

      fetchBookingsData();
      fetchVacantRooms();
      roomNoController.clear();
      nameController.clear();
      dateController.clear();
      phoneNoController.clear();
      notifyListeners();
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Booking Added Successfull")));
    } catch (e) {
      print(e.toString());
    }
  }

  // delete booking

  deleteBooking({
    required BuildContext context,
    required String bookingId,
    required String roomId,
  }) async {
    try {
      final isConnected = await connectionController.isConnected();
      if (!isConnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Network error")));
      }

      await bookingController.deleteBooking(bookingId);

// fetching current vaccancy from roomdata to update vacancy
      final RoomModel? room =
          await roomController.fetchSingleRoom(roomId: roomId);
      final currentVacancy = room!.vacancy;

      final int vacancy = currentVacancy + 1;
      notifyListeners();

      final Map<String, dynamic> json = {"Vacancy": vacancy};

      await roomController.updateSingleField(json: json, roomId: roomId);

      fetchBookingsData();
      fetchVacantRooms();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Record Deleted Successfully")));
    } catch (e) {
      print(e.toString());
    }
  }

// check In date assigning

  void setDate(DateTime date) {
    if (date != null) {
      checkInDate = date;
      dateController.text = "${checkInDate.toLocal()}".split(' ')[0];
    }

    notifyListeners();
  }

// advance paid or not radio button function

  void advance(bool value) {
    isAdvancePaid = value;
    notifyListeners();
  }

  fieldValidation(value) {
    if (value == null || value.isEmpty) {
      return "this Field is required.";
    } else {
      return null;
    }
  }
}

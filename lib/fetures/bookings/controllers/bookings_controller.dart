// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/bookings/controllers/bookings_repository.dart';
import 'package:hostel_management_app/commens/functions/connection_checher.dart';
import 'package:hostel_management_app/fetures/rooms/controllers/rooms_repository.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_repository.dart';
import 'package:hostel_management_app/fetures/bookings/models/booking_model.dart';
import 'package:hostel_management_app/fetures/profile/models/owner_model.dart';
import 'package:hostel_management_app/fetures/rooms/models/room_model.dart';
import 'package:intl/intl.dart';

class BookingsController with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final roomNoController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final dateController = TextEditingController();

  final BookingRepository bookingController = BookingRepository();
  final ConnectionChecker connectionController = ConnectionChecker();
  final RoomsRepository roomController = RoomsRepository();
  final UserRepository ownerRepository = UserRepository();
  
  List<BookingsModel> allBookings = [];
  List<BookingsModel> bookings = [];
  List<BookingsModel> bookingsWithinThisWeek = [];
  List<RoomModel> vacantRooms = [];
  bool isAdvancePaid = true;
  bool isBookingsLoading = false;
  bool isRoomsLoading = false;
  DateTime checkInDate = DateTime.now();
  bool isEditing = false;
  String? updatingBookingId;

//----------------------------------------------------------------------------- fetching vacant rooms

  fetchVacantRooms() async {
    try {
      isRoomsLoading = true;
      List<RoomModel> allRooms = await roomController.fetchData();
      // Filter out vacant rooms (Vacancy > 0)
      vacantRooms = allRooms.where((room) => room.vacancy > 0).toList();
      vacantRooms.sort((a, b) => a.roomNo.compareTo(b.roomNo));
    } catch (e) {
      rethrow; // or return an empty list or handle the error appropriately
    } finally {
      isRoomsLoading = false;
      notifyListeners();
    }
  }

  //--------------------------------------------------------------------------- fetch Bookings data
  fetchBookingsData() async {
    try {
      isBookingsLoading = true;

      allBookings = await bookingController.fetchData();
      allBookings.sort((a, b) => a.checkIn.compareTo(b.checkIn));
      bookings = allBookings;
      await filterBooking();

      isBookingsLoading = false;
      notifyListeners();
    } catch (e) {
      rethrow; // or return an empty list or handle the error appropriately
    } finally {
      isBookingsLoading = false;
      notifyListeners();
    }
  }

  //----------------------------------------------------------------------------Filtering bookings
  filterBooking() async {
    // Clear the list before adding new data
    bookingsWithinThisWeek.clear();

    // Get the current date and time
    final currentDate = DateTime.now();

    // Filter bookings with check-in date within this week
    final thisWeekBookings = allBookings.where((booking) {
      final daysDifference = booking.checkIn.difference(currentDate).inDays;
      return daysDifference < 20;
    }).toList();

    // Move the filtered bookings to another list
    bookingsWithinThisWeek.addAll(thisWeekBookings);
  }

  //----------------------------------------------------------------------------add booking

  addBooking({
    required BuildContext context,
    required int roomNo,
    required String roomId,
  }) async {
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

      // fetching current vaccancy from roomdata to update vacancy
      final RoomModel? room =
          await roomController.fetchSingleRoom(roomId: roomId);
      final currentRoomVacancy = room!.vacancy;
      final int roomVacancy = currentRoomVacancy - 1;
      notifyListeners();
      final Map<String, dynamic> json = {"Vacancy": roomVacancy};
      await roomController.updateSingleField(json: json, roomId: roomId);
      final OwnerModel? owner = await ownerRepository.fetchOwnerRecords();
      final currentHostelVacancy = owner!.noOfVacancy;
      final int hostelVacancy = currentHostelVacancy - 1;
      notifyListeners();
      final Map<String, dynamic> data = {'NoOfVacancy': hostelVacancy};
      await ownerRepository.accountSetup(data);

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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  //--------------------------------------------------------------------------- delete booking

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

      final OwnerModel? owner = await ownerRepository.fetchOwnerRecords();
      final currentHostelVacancy = owner!.noOfVacancy;
      final int hostelVacancy = currentHostelVacancy + 1;
      notifyListeners();
      final Map<String, dynamic> data = {'NoOfVacancy': hostelVacancy};
      await ownerRepository.accountSetup(data);

      fetchBookingsData();
      fetchVacantRooms();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Record Deleted Successfully")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  //--------------------------------------------------------------------------- Update Booking

  updateBooking(BuildContext context) async {
    try {
      final Map<String, dynamic> json = {
        "Name": nameController.text,
        "phoneNo": phoneNoController.text.trim(),
        "CheckIn": checkInDate,
        "AdvancePaid": isAdvancePaid
      };

      await bookingController.updadatSingleField(
          json: json, bookingId: updatingBookingId!);

      fetchBookingsData();
      fetchVacantRooms();
      onCanacel();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Record Edited Successfully")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

//----------------------------------------------------------------------------- on edit tap

  onEdit({required BookingsModel booking}) {
    isEditing = true;
    nameController.text = booking.name;
    phoneNoController.text = booking.phoneNo;
    dateController.text = DateFormat("dd/MM/yyyy").format(booking.checkIn);
    checkInDate = booking.checkIn;
    updatingBookingId = booking.id;
    isAdvancePaid = booking.advancePaid;
    notifyListeners();
  }

  //----------------------------------------------------------------------------bookings filter
  String selectedFilter = "All";
  List<String> filters = ["All", "This Week", "This Month"];
  int selectedDays = 7;
  selectFilter(filter) async {
    selectedFilter = filter;
    if (selectedFilter == "This Week") {
      selectedDays = 7;
      filterBookings();
    } else if (selectedFilter == "This Month") {
      selectedDays = 30;
      filterBookings();
    } else if (selectedFilter == "All") {
      bookings = allBookings;
    }
    notifyListeners();
  }

  filterBookings() async {
    try {
      // Get the current date and time
      final currentDate = DateTime.now();

      // Filter bookings with check-in date within this week
      final filteredBookings = allBookings.where((booking) {
        final daysDifference = booking.checkIn.difference(currentDate).inDays;
        return daysDifference >= 0 && daysDifference < selectedDays;
      }).toList();

      bookings = filteredBookings;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  //----------------------------------------------------------------------------on cancel
  onCanacel() {
    isEditing = false;
    nameController.clear();
    phoneNoController.clear();
    dateController.clear();
    isAdvancePaid = false;
    notifyListeners();
  }

//----------------------------------------------------------------------------- check In date assigning

  void setDate(DateTime date) {
    checkInDate = date;
    dateController.text = "${checkInDate.toLocal()}".split(' ')[0];

    notifyListeners();
  }

//----------------------------------------------------------------------------- advance paid or not radio button function

  void advance(bool value) {
    isAdvancePaid = value;
    notifyListeners();
  }
//------------------------------------------------------------------------------Text field validation

  fieldValidation(value) {
    if (value == null || value.isEmpty) {
      return "this Field is required.";
    } else {
      return null;
    }
  }
}

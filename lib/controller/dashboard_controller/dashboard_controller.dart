import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/residents/residents_repository.dart';
import 'package:hostel_management_app/controller/users/owner_repository.dart';
import 'package:hostel_management_app/model/owner_model.dart';
import 'package:hostel_management_app/model/resident_model.dart';
import 'package:intl/intl.dart';

class DashboardController with ChangeNotifier {
  OwnerModel? user = OwnerModel.empty();
  List<Map<String, int>> roomsGoingtoVacant = [];
  String selectedValue = "This Week";
  int selectedDays = 7;
  List<String> sortingItems = ["This Week", "This Month", "This Year"];
  List<ResidentModel> allResidents = [];
  List<ResidentModel> rentPendingResidents = [];
  final OwnerRepository controller = OwnerRepository();
  final ResidentsRepository residentsRepository = ResidentsRepository();

  fetchData() async {
    try {
      final currentUser = await controller.fetchOwnerRecords();
      allResidents = await residentsRepository.fetchData();
      user = currentUser;
      notifyListeners();
      getVacatingRooms();
      getPendingPayments();
    } catch (e) {
      user = OwnerModel.empty();
      notifyListeners();
      print(e);
    }
  }

  getVacatingRooms() async {
    try {
      // Get the current date and time
      final currentDate = DateTime.now();

      // Filter bookings with check-in date within this week
      final thisWeekVaccating = allResidents.where((resident) {
        final daysDifference = resident.checkOut.difference(currentDate).inDays;
        return daysDifference >= 0 && daysDifference < selectedDays;
      }).toList();

      roomsGoingtoVacant = await getVacancyCount(thisWeekVaccating);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getPendingPayments() async {
    for (ResidentModel resident in allResidents) {
      if (resident.isRentPaid == false) {
        rentPendingResidents.add(resident);
      }
      notifyListeners();
    }
  }

  List<Map<String, int>> getVacancyCount(
      List<ResidentModel> vacatingResidents) {
    Map<int, int> roomCountMap = {};

    // Count the number of residents vacating each room
    for (ResidentModel resident in vacatingResidents) {
      int roomNo = resident.roomNo;
      roomCountMap.update(roomNo, (value) => value + 1, ifAbsent: () => 1);
    }

    // Convert the roomCountMap to the desired format
    List<Map<String, int>> result = roomCountMap.entries.map((entry) {
      return {"RoomNo": entry.key, "Vacancy": entry.value};
    }).toList();

    return result;
  }

  selectFilter(filter) async {
    selectedValue = filter;
    notifyListeners();
    if (selectedValue == "This Week") {
      selectedDays = 7;
      notifyListeners();
    } else if (selectedValue == "This Month") {
      selectedDays = 30;
      notifyListeners();
    } else if (selectedValue == "This Year") {
      selectedDays = 365;
      notifyListeners();
    }
    getVacatingRooms();
  }

  String date() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }
}

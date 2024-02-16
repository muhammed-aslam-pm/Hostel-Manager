// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/residents/controllers/residents_repository.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_repository.dart';
import 'package:hostel_management_app/fetures/profile/models/owner_model.dart';
import 'package:hostel_management_app/fetures/residents/models/resident_model.dart';
import 'package:hostel_management_app/fetures/rooms/controllers/rooms_repository.dart';
import 'package:hostel_management_app/fetures/rooms/models/room_model.dart';
import 'package:intl/intl.dart';

class DashboardController with ChangeNotifier {
  OwnerModel? user = OwnerModel.empty();
  List<Map<String, int>> roomsGoingtoVacant = [];
  String selectedValue = "This Week";
  int selectedDays = 7;
  List<String> sortingItems = ["This Week", "This Month", "This Year"];
  bool isFilterLoading = false;
  bool isPaymentsLoading = false;
  List<ResidentModel> allResidents = [];
  List<ResidentModel> rentPendingResidents = [];
  List<ResidentModel> paymentDueResidents = [];
  List<Map<String, dynamic>> pendingPayments = [];
  int totalPentingAmount = 0;

  final UserRepository controller = UserRepository();
  final ResidentsRepository residentsRepository = ResidentsRepository();
  final roomController = RoomsRepository();
//------------------------------------------------------------------------------Fetch data
  fetchData() async {
    try {
      isFilterLoading = true;
      final currentUser = await controller.fetchOwnerRecords();
      allResidents = await residentsRepository.fetchData();
      user = currentUser;
      notifyListeners();
      getVacatingRooms();
      await updatePendingPayments();

      isFilterLoading = false;
      notifyListeners();
    } catch (e) {
      user = OwnerModel.empty();
      notifyListeners();
      print(e);
    }
  }
//------------------------------------------------------------------------------Fetch vacating Rooms

  getVacatingRooms() async {
    try {
      isFilterLoading = true;

      // Get the current date and time
      final currentDate = DateTime.now();

      // Filter bookings with check-in date within this week
      final thisWeekVaccating = allResidents.where((resident) {
        final daysDifference = resident.checkOut.difference(currentDate).inDays;
        return daysDifference < selectedDays;
      }).toList();

      roomsGoingtoVacant = getVacancyCount(thisWeekVaccating);
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isFilterLoading = false;
      notifyListeners();
    }
  }
//------------------------------------------------------------------------------Update Pending payments

  updatePendingPayments() async {
    try {
      isPaymentsLoading = true;
      paymentDueResidents.clear();
      rentPendingResidents.clear();
      pendingPayments.clear();
      totalPentingAmount = 0;
      final currentDate = DateTime.now();
      paymentDueResidents = allResidents
          .where((resident) =>
              currentDate.isAfter(resident.nextRentDate) ||
              currentDate.isAtSameMomentAs(resident.nextRentDate))
          .toList();

      if (paymentDueResidents.isNotEmpty) {
        Map<String, dynamic> json = {'Rentpaid': false};

        for (int i = 0; i < paymentDueResidents.length; i++) {
          await residentsRepository.updateSingleField(
              paymentDueResidents[i].id!, json);
        }
        for (ResidentModel resident in allResidents) {
          if (resident.isRentPaid == false) {
            rentPendingResidents.add(resident);
          }
        }
        pendingPayments =
            await convertResidentsListToMapList(rentPendingResidents);
        isFilterLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching residents data: $e');
    } finally {
      isPaymentsLoading = false;
    }
  }
//------------------------------------------------------------------------------get Vacancy Count

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

  //----------------------------------------------------------------------------Convert rent pending residents to map
  Future<List<Map<String, dynamic>>> convertResidentsListToMapList(
    List<ResidentModel> residentsList,
  ) async {
    Map<int, List<ResidentModel>> residentsMap = {};

    for (var resident in residentsList) {
      if (!residentsMap.containsKey(resident.roomNo)) {
        residentsMap[resident.roomNo] = [];
      }

      residentsMap[resident.roomNo]!.add(resident);
    }

    List<Map<String, dynamic>> resultList = [];

    for (var entry in residentsMap.entries) {
      int roomNo = entry.key;
      List<ResidentModel> residents = entry.value;

      RoomModel roomModel =
          await roomController.getRoomByRoomNo(roomNo) ?? RoomModel.empty();

      int totalAmount = roomModel.rent * residents.length;
      totalPentingAmount = totalPentingAmount + totalAmount;
      resultList.add({
        "RoomNo": roomNo,
        "Residents": residents,
        "TotalAmount": totalAmount,
      });
    }

    return resultList;
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

    await getVacatingRooms();
  }

  String date() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }
}

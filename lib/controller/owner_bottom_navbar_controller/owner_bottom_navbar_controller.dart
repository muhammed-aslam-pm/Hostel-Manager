import 'package:flutter/material.dart';
import 'package:hostel_management_app/owner_booking_page/owner_bookings_page.dart';
import 'package:hostel_management_app/owner_dashboard/owner_dashboard_page.dart';
import 'package:hostel_management_app/owner_residents_page/owner_residents_page.dart';
import 'package:hostel_management_app/owner_rooms_page/owner_rooms_page.dart';

class OwnerNavBarController with ChangeNotifier {
  int selectedIndex = 0;
  List<Widget> ownerPages = [
    OwnerDashBoardPage(),
    OwnerRoomsPage(),
    OwnerBookingsPage(),
    OwnerResidentsPage()
  ];

  void onNavTap(index) {
    selectedIndex = index;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:hostel_management_app/view/booking_page/bookings_page.dart';
import 'package:hostel_management_app/view/dashboard_page/dashboard_page.dart';
import 'package:hostel_management_app/view/residents_page/residents_page.dart';
import 'package:hostel_management_app/view/rooms_page/owner_rooms_page.dart';

class OwnerNavBarController with ChangeNotifier {
  int selectedIndex = 0;
  List<Widget> ownerPages = [
    const DashBoardPage(),
    const OwnerRoomsPage(),
    const BookingsPage(),
    const ResidentsPage(),
  ];

  void onNavTap(index) {
    selectedIndex = index;
    notifyListeners();
  }
}

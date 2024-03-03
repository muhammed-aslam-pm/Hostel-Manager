import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/bookings/screens/bookings_page.dart';
import 'package:hostel_management_app/fetures/dashboard/screens/dashboard_page.dart';
import 'package:hostel_management_app/fetures/residents/screens/residents_page.dart';
import 'package:hostel_management_app/fetures/rooms/screens/rooms_page.dart';

class NavBarController with ChangeNotifier {
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

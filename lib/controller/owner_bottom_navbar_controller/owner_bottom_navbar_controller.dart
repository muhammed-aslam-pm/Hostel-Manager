import 'package:flutter/material.dart';

class OwnerNavBarController with ChangeNotifier {
  int selectedIndex = 0;

  void onNavTap(index) {
    selectedIndex = index;
    notifyListeners();
  }
}

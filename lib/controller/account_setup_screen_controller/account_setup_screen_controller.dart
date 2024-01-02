import 'package:flutter/material.dart';

class AccountSetUpScreenController with ChangeNotifier {
  List<String> floorList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];
  String selectedValue = "1";
  notifyListeners();

  onChanged({required String value}) {
    selectedValue = value;
    notifyListeners();
  }
}

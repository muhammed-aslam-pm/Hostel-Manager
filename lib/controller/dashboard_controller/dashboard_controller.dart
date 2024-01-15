import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/users/owner_repository.dart';
import 'package:hostel_management_app/model/owner_model.dart';
import 'package:intl/intl.dart';

class DashboardController with ChangeNotifier {
  OwnerModel? user = OwnerModel.empty();
  final OwnerRepository controller = OwnerRepository();

  fetchData() async {
    try {
      final currentUser = await controller.fetchOwnerRecords();
      user = currentUser;
      notifyListeners();
    } catch (e) {
      user = OwnerModel.empty();
      notifyListeners();
    }
  }

  String date() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }
}

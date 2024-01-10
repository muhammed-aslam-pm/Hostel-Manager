import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/users/owner_repository.dart';
import 'package:hostel_management_app/model/owner_model.dart';

class UserController with ChangeNotifier {
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
}

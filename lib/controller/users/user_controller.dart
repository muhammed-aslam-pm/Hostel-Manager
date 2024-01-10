import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/loading/loading_controller.dart';
import 'package:hostel_management_app/controller/users/owner_repository.dart';
import 'package:hostel_management_app/model/owner_model.dart';

class UserController with ChangeNotifier {
  OwnerModel? user = OwnerModel.empty();
  final OwnerRepository controller = OwnerRepository();
  final loadingController = FullScreenLoader();

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

  final nameController = TextEditingController();
  final hostelNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final addressController = TextEditingController();
  final roonNoController = TextEditingController();
  GlobalKey<FormState> profileUpdateFormKey = GlobalKey<FormState>();

  fillForm() {
    nameController.text = user!.ownwerName;
    hostelNameController.text = user!.hostelName;
    emailController.text = user!.emailAddress;
    phoneNoController.text = user!.mobileNumber;
    addressController.text = user!.address;
    roonNoController.text = user!.noOfRooms.toString();
  }

  updateData(context) async {
    try {
      FullScreenLoader.openLoadinDialog(context);
      final updatedUser = OwnerModel(
        id: user!.id,
        hostelName: hostelNameController.text,
        address: addressController.text,
        emailAddress: emailController.text,
        mobileNumber: phoneNoController.text,
        ownwerName: nameController.text,
        profilePictuer: user!.profilePictuer,
        noOfRooms: int.parse(roonNoController.text),
        noOfBeds: user!.noOfBeds,
        isAccountSetupCompleted: true,
      );
      await controller.updateOwnerRecords(updatedUser);
      fetchData();
      FullScreenLoader.stopLoadin(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Profile Updated Successfull")));
    } catch (e) {
      print(e.toString());
    }
  }

  fieldValidation(value) {
    if (value == null || value.isEmpty) {
      return "Name is required.";
    } else {
      return null;
    }
  }
}

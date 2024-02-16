// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/authentication/controllers/authentication_repository.dart';
import 'package:hostel_management_app/commens/functions/loading_controller.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_repository.dart';
import 'package:hostel_management_app/fetures/profile/models/owner_model.dart';
import 'package:hostel_management_app/fetures/authentication/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';

class UserController with ChangeNotifier {
  OwnerModel? user = OwnerModel.empty();
  final UserRepository controller = UserRepository();
  final loadingController = FullScreenLoader();
  bool isProfileUploading = false;

  //----------------------------------------------------------------------------Fetch user data

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
  //----------------------------------------------------------------------------Update user data

  updateData(context) async {
    try {
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
        noOfVacancy: user!.noOfVacancy,
        isAccountSetupCompleted: true,
      );
      await controller.updateOwnerRecords(updatedUser);
      fetchData();

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile Updated Successfull")));
    } catch (e) {
      print(e.toString());
    }
  }
  //----------------------------------------------------------------------------Delte user

  deleteUserAccount(context) async {
    try {
      final auth = AuthenticationRepository();
      await auth.deleteAccount();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account Deleted Successfully")));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false);
    } catch (e) {
      print(e.toString());
    }
  }
  //----------------------------------------------------------------------------Upload profile pick

  uploadUserProfilePicture(context) async {
    try {
      isProfileUploading = true;
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        final imageUrl =
            await controller.uploadImage('Owners/Images/Profile', image);

        Map<String, dynamic> json = {"ProfilePictuer": imageUrl};
        controller.accountSetup(json);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Profile picture Changed Sussefully")));

        fetchData();
        isProfileUploading = false;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isProfileUploading = false;
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

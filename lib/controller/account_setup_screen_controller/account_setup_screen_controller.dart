import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/users/owner_repository.dart';
import 'package:hostel_management_app/view/owner_home_screen/owner_home_screen.dart';

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
  List<int> noOfRooms = [];
  final hostelNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final roomNumberController = TextEditingController();
  GlobalKey<FormState> accountSetupFormKey = GlobalKey<FormState>();

  final OwnerRepository controller = OwnerRepository();

  Future<void> updateOwnerRecords(BuildContext context) async {
    final currentUser = await FirebaseAuth.instance.currentUser;
    controller.accountSetup(
        id: currentUser!.uid,
        mobileNumber: phoneNumberController.text,
        hostelName: hostelNameController.text,
        profilePictuer: "",
        noOfRooms: int.parse(roomNumberController.text));

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OwnerHomeScreen(),
        ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/authentication/owner_controller.dart';
import 'package:hostel_management_app/view/owner_home_screen/owner_home_screen.dart';
import 'package:provider/provider.dart';

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

  final OwnerController controller = OwnerController();

  Future<void> updateOwnerRecords(BuildContext context) async {
    final currentUser = await FirebaseAuth.instance.currentUser;
    controller.updateOwnerRecords(
        id: currentUser!.uid,
        mobileNumber: phoneNumberController.text,
        hostelName: hostelNameController.text,
        profilePictuer: "",
        noOfRooms: int.parse(roomNumberController.text));

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OwnerHomeScreen(),
        ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/users/owner_repository.dart';
import 'package:hostel_management_app/view/home_screen/home_screen.dart';

class AccountSetUpScreenController with ChangeNotifier {
  List<int> noOfRooms = [];
  final hostelNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final roomNumberController = TextEditingController();
  GlobalKey<FormState> accountSetupFormKey = GlobalKey<FormState>();

  final OwnerRepository controller = OwnerRepository();

  Future<void> updateOwnerRecords(BuildContext context) async {
    final currentUser = await FirebaseAuth.instance.currentUser;

    final Map<String, dynamic> jason = {
      'HostelName': hostelNameController.text,
      'Address': addressController.text ?? "",
      'MobileNumber': phoneNumberController.text,
      'ProfilePictuer': "",
      'NoOfRooms': int.parse(roomNumberController.text),
      'AccountSetupcompleted': true
    };

    controller.accountSetup(jason);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/users/user_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/view/owner_profile_screen/widgets/confirm_logout_dialog.dart';
import 'package:hostel_management_app/view/owner_profile_screen/widgets/profile_detailes_card.dart';
import 'package:hostel_management_app/view/owner_profile_screen/widgets/room_no_card.dart';
import 'package:provider/provider.dart';

class OwnerProfileScreen extends StatelessWidget {
  const OwnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UserController>(context);
    final gap = const SizedBox(
      height: 20,
    );
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryWhiteColor,
        iconTheme: IconThemeData(color: ColorConstants.primaryBlackColor),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left_outlined,
            size: 30,
          ),
        ),
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            itemBuilder: (context) {
              return [
                // In this case, we need 5 popupmenuItems one for each option.
                const PopupMenuItem(child: Text('Edit')),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Text(
                        'Log Out',
                        style: TextStyle(color: ColorConstants.colorRed),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.logout,
                        size: 20,
                        color: ColorConstants.colorRed,
                      )
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmLogoutDialog(),
                    );
                  },
                ),
              ];
            },
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "profile",
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: ColorConstants.SecondaryColor4,
                  child: Icon(Icons.person),
                ),
              ),
              ProfileDetailesCard(
                title: "",
                data: controller.user!.hostelName,
              ),
              gap,
              ProfileDetailesCard(
                title: "Address",
                data: controller.user!.address,
              ),
              gap,
              ProfileDetailesCard(
                  title: "Owner Name", data: controller.user!.ownwerName),
              gap,
              ProfileDetailesCard(
                  title: "Phone Number", data: controller.user!.mobileNumber),
              gap,
              ProfileDetailesCard(
                  title: "Email", data: controller.user!.emailAddress),
              gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NumberCard(
                      title: "No of Rooms",
                      number: controller.user!.noOfRooms.toString()),
                  NumberCard(
                      title: "No of Beds",
                      number: controller.user!.noOfBeds.toString())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

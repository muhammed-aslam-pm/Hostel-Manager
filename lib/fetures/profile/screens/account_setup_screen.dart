import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/profile/controllers/account_setup_screen_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/commens/widgets/login_button.dart';
import 'package:provider/provider.dart';

class AccountSetupScreen extends StatelessWidget {
  const AccountSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AccountSetUpScreenController>(context);
    return Scaffold(
      backgroundColor: ColorConstants.secondaryWhiteColor,
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 85 / 100,
            width: MediaQuery.sizeOf(context).width * 90 / 100,
            decoration: BoxDecoration(
                color: ColorConstants.primaryWhiteColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.primaryBlackColor.withOpacity(0.3),
                    blurRadius: 1,
                    offset: const Offset(0, 2), // Offset for the bottom shadow
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.accountSetupFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Set Up Your\nHostel",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorConstants.primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Stack(
                            children: [
                              Positioned(
                                child: Hero(
                                  tag: Form,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        ColorConstants.secondaryColor4,
                                    child: Icon(
                                      Icons.person,
                                      color: ColorConstants.primaryBlackColor,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 3,
                                right: 3,
                                child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor:
                                      ColorConstants.secondaryColor5,
                                  child: const Icon(Icons.add),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Your Hostel Name",
                        style: TextStyleConstants.dashboardBookingName,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: controller.hostelNameController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: ColorConstants.primaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: ColorConstants.primaryColor),
                              ),
                              counterStyle: TextStyle(
                                  color: ColorConstants.primaryBlackColor)),
                          cursorColor: ColorConstants.primaryBlackColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Address",
                        style: TextStyleConstants.dashboardBookingName,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 100,
                        child: TextFormField(
                          controller: controller.addressController,
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: ColorConstants.primaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: ColorConstants.primaryColor),
                              ),
                              counterStyle: TextStyle(
                                  color: ColorConstants.primaryBlackColor)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Phone no",
                        style: TextStyleConstants.dashboardBookingName,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: controller.phoneNumberController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: ColorConstants.primaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: ColorConstants.primaryColor),
                              ),
                              counterStyle: TextStyle(
                                  color: ColorConstants.primaryBlackColor)),
                          cursorColor: ColorConstants.primaryBlackColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "No of Roms :        ",
                            style: TextStyleConstants.dashboardBookingName,
                          ),
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: TextFormField(
                              controller: controller.roomNumberController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: ColorConstants.primaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: ColorConstants.primaryColor),
                                  ),
                                  counterStyle: TextStyle(
                                      color: ColorConstants.primaryBlackColor)),
                              cursorColor: ColorConstants.primaryBlackColor,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LoginButton(
                        buttonName: "Continue",
                        onTap: () {
                          Provider.of<AccountSetUpScreenController>(context,
                                  listen: false)
                              .updateOwnerRecords(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

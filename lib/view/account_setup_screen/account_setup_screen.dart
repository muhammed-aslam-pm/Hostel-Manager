import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/account_setup_screen_controller/account_setup_screen_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/view/global_widgets/custom_dropdown_button.dart';
import 'package:provider/provider.dart';

class AccountSetupScreen extends StatelessWidget {
  const AccountSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Hero(
                          tag: Form,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: ColorConstants.SecondaryColor4,
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
                          backgroundColor: ColorConstants.SecondaryColor5,
                          child: Icon(Icons.add),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Your Hostel Name"),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 1, color: ColorConstants.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 2, color: ColorConstants.primaryColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("No of Floors :     "),
                  CustomDropdownButton1(
                    height: 50,
                    width: 100,
                    selectedValue:
                        Provider.of<AccountSetUpScreenController>(context)
                            .selectedValue,
                    items: Provider.of<AccountSetUpScreenController>(context)
                        .floorList,
                    onChanged: (value) {
                      Provider.of<AccountSetUpScreenController>(context,
                              listen: false)
                          .onChanged(value: value);
                      // Call the onChanged method from the respective controller
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

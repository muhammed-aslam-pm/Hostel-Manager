import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';

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
            Text("Room no"),
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
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Bed no"),
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
          ],
        ),
      )),
    );
  }
}

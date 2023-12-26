import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'dart:ui' as ui;

import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class AddBookingScreen extends StatelessWidget {
  const AddBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: 5.0,
        sigmaY: 5.0,
      ),
      child: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: ColorConstants.SecondaryColor5,
              borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.all(25),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: ColorConstants.primaryWhiteColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: ColorConstants.primaryWhiteColor,
                            child: Hero(
                              tag: Image,
                              child: Image.asset(
                                ImageConstants.roomsIcon2,
                                color: ColorConstants.primaryBlackColor,
                              ),
                            ),
                          ),
                          Text(
                            "Room No",
                            style: TextStyleConstants.OwnerRoomNumber2,
                          ),
                          Text(
                            "10",
                            style: TextStyleConstants.OwnerRoomNumber3,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
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
                                width: 1.5,
                                color: ColorConstants.primaryWhiteColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 2,
                                color: ColorConstants.primaryWhiteColor),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Name "),
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
                                width: 1.5,
                                color: ColorConstants.primaryWhiteColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 2,
                                color: ColorConstants.primaryWhiteColor),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Phone no"),
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
                                width: 1.5,
                                color: ColorConstants.primaryWhiteColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 2,
                                color: ColorConstants.primaryWhiteColor),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Joining date"),
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
                                width: 1.5,
                                color: ColorConstants.primaryWhiteColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 2,
                                color: ColorConstants.primaryWhiteColor),
                          ),
                          suffixIcon: Icon(
                            Icons.calendar_month_outlined,
                            color: ColorConstants.primaryWhiteColor,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Advance"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      RadioMenuButton(
                        value: true,
                        groupValue: true,
                        onChanged: (value) {},
                        child: Text("Paid"),
                      ),
                      RadioMenuButton(
                          value: false,
                          groupValue: true,
                          onChanged: (value) {},
                          child: Text("Not Paid"))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: ColorConstants.primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyleConstants.buttonText,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

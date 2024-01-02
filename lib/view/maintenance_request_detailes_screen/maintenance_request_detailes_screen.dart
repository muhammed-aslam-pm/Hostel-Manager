import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class MaintenanceRequestDetailesScreen extends StatelessWidget {
  const MaintenanceRequestDetailesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      appBar: AppBar(
        title: Hero(
          tag: "Maintenance request",
          child: Text(
            "Maintenance request",
            style: TextStyleConstants.homeMainTitle2,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: ColorConstants.primaryColor,
            )),
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: ColorConstants.SecondaryColor4,
                    child: Image.asset(
                      ImageConstants.ownerRoomsIconeDisabled,
                      color: ColorConstants.primaryBlackColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Room No 17",
                        style: TextStyleConstants.OwnerRoomNumber,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ImageConstants.calenderIcon,
                          ),
                          Text(
                            "08 sep due",
                            style: TextStyleConstants.dashboardPendingDue,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(" Complaints"),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.SecondaryColor1,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request 1",
                      style: TextStyleConstants.dashboardBookingName,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description..........................................\n .................................\n......................................",
                      style: TextStyleConstants.ownerRoomsText2,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.SecondaryColor1,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request 2",
                      style: TextStyleConstants.dashboardBookingName,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description..........................................\n .................................\n......................................",
                      style: TextStyleConstants.ownerRoomsText2,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.SecondaryColor1,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request 3",
                      style: TextStyleConstants.dashboardBookingName,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description..........................................\n .................................\n......................................",
                      style: TextStyleConstants.ownerRoomsText2,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: false,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: TextFormField(
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: ColorConstants.primaryColor),
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Center(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.comment,
                                      color: ColorConstants.primaryWhiteColor,
                                      size: 17,
                                    ),
                                    Text(
                                      " Sent",
                                      style: TextStyleConstants.buttonText,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.comment,
                              color: ColorConstants.primaryWhiteColor,
                              size: 17,
                            ),
                            Text(
                              " Replay",
                              style: TextStyleConstants.buttonText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.colorGreen.withGreen(100),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Center(
                        child: Text(
                          "Mark as Done ",
                          style: TextStyleConstants.buttonText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/room_detailes_screen/widgets/facilities_card.dart';
import 'dart:ui' as ui;

import 'package:hostel_management_app/view/room_detailes_screen/widgets/residents_name_card.dart';

class RoomsViewScreen extends StatelessWidget {
  const RoomsViewScreen(
      {super.key,
      required this.roomNumber,
      required this.numberOfBeds,
      required this.numberOfVaccentBeds});

  final String roomNumber;
  final String numberOfBeds;
  final String numberOfVaccentBeds;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: 1.0,
        sigmaY: 1.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Container(
          decoration: BoxDecoration(
              color: ColorConstants.primaryColor.withOpacity(.7),
              borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.all(15),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: ColorConstants.primaryWhiteColor,
                              )),
                        ],
                      ),
                      Hero(
                        tag: "room",
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: ColorConstants.primaryWhiteColor,
                          child: Image.asset(
                            ImageConstants.roomsIcon2,
                            color: ColorConstants.primaryBlackColor,
                          ),
                        ),
                      ),
                      Hero(
                        tag: "roomNo",
                        child: Text(
                          "Room No",
                          style: TextStyleConstants.OwnerRoomNumber2,
                        ),
                      ),
                      Text(
                        roomNumber,
                        style: TextStyleConstants.OwnerRoomNumber3,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ColorConstants.primaryWhiteColor),
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  ColorConstants.bedCircleAvtarColor,
                              child: Image.asset(
                                ImageConstants.moneyIcon,
                                color: ColorConstants.primaryBlackColor,
                              ),
                            ),
                            Text(
                              "  5750",
                              style: TextStyleConstants.dashboardBookingName,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ColorConstants.primaryWhiteColor),
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  ColorConstants.bedCircleAvtarColor,
                              child: Image.asset(
                                ImageConstants.bedIcon2,
                                color: ColorConstants.primaryBlackColor,
                              ),
                            ),
                            Text(
                              "  Total Bed : ",
                              style: TextStyleConstants.ownerRoomsText2,
                            ),
                            Text(
                              numberOfBeds,
                              style: TextStyleConstants.dashboardVacentRoom1,
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ColorConstants.primaryWhiteColor),
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  ColorConstants.bedCircleAvtarColor,
                              child: Image.asset(
                                ImageConstants.bedIcon2,
                                color: ColorConstants.primaryBlackColor,
                              ),
                            ),
                            Text(
                              "  Vacant Bed : ",
                              style: TextStyleConstants.ownerRoomsText2,
                            ),
                            Text(
                              numberOfVaccentBeds,
                              style: TextStyleConstants.dashboardVacentRoom1,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Facilities :",
                        style: TextStyleConstants.OwnerRoomNumber2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FacilitiesCard(
                          name: "Washing Machine",
                          icon: ImageConstants.washingMachineIcon,
                        ),
                        FacilitiesCard(
                            name: "A/c", icon: ImageConstants.ACIcon),
                        FacilitiesCard(
                            name: "Atteched Bathroom",
                            icon: ImageConstants.bathroomIcon),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Residents :",
                        style: TextStyleConstants.OwnerRoomNumber2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ResidentsNameCard(),
                    separatorBuilder: (context, index) => Divider(
                      height: 10,
                    ),
                    itemCount: int.parse(numberOfBeds) -
                        int.parse(numberOfVaccentBeds),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

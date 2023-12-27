import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/room_detailes_screen/widgets/penting_payment_name_card.dart';
import 'dart:ui' as ui;

class RoomsViewScreen extends StatelessWidget {
  RoomsViewScreen(
      {super.key,
      required this.roomNumber,
      required this.numberOfBeds,
      required this.numberOfVaccentBeds});

  String roomNumber;
  String numberOfBeds;
  String numberOfVaccentBeds;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: 1.0,
        sigmaY: 1.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 120),
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
                        roomNumber,
                        style: TextStyleConstants.OwnerRoomNumber3,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width:
                            MediaQuery.sizeOf(context).width * (50 / 100) - 35,
                        height: 200,
                        child: Stack(children: [
                          Positioned(
                            top: 25,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 10),
                              height: 142,
                              width: MediaQuery.sizeOf(context).width *
                                      (50 / 100) -
                                  35,
                              decoration: BoxDecoration(
                                color: ColorConstants.primaryWhiteColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Bed Vaccent",
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            TextStyleConstants.ownerRoomsText2,
                                      ),
                                      Text(
                                        numberOfVaccentBeds,
                                        style: TextStyleConstants
                                            .dashboardVacentRoom1,
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Total Bed",
                                        style:
                                            TextStyleConstants.ownerRoomsText2,
                                      ),
                                      Text(
                                        numberOfBeds,
                                        style: TextStyleConstants
                                            .dashboardVacentRoom1,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: 10,
                              right: 10,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                    ColorConstants.bedCircleAvtarColor,
                                child: Image.asset(
                                  ImageConstants.bedIcon2,
                                  color: ColorConstants.primaryBlackColor,
                                ),
                              )),
                        ]),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: ColorConstants.roomsBlackColor
                                  .withOpacity(.25),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                "Pending Payments",
                                style: TextStyleConstants.upComingVaccencyText1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            PentingPaymentNameCard(
                              name: "Rahul",
                              amount: "1000",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            PentingPaymentNameCard(
                              name: "Rahul",
                              amount: "1000",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            PentingPaymentNameCard(
                              name: "Rahul",
                              amount: "1000",
                            ),
                          ],
                        ),
                      )
                    ],
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

import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/rooms/rooms_controller.dart';
import 'package:hostel_management_app/controller/users/user_controller.dart';
import 'package:hostel_management_app/model/room_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/room_detailes_screen/widgets/facilities_card.dart';
import 'dart:ui' as ui;

import 'package:hostel_management_app/view/room_detailes_screen/widgets/residents_name_card.dart';
import 'package:provider/provider.dart';

class RoomsViewScreen extends StatelessWidget {
  const RoomsViewScreen({super.key, required this.roomDetailes});

  final RoomModel roomDetailes;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RoomsController>(context);
    final userController = Provider.of<UserController>(context, listen: false);
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
          padding: const EdgeInsets.all(15),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: ColorConstants.primaryWhiteColor,
                  )),
              actions: [
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  itemBuilder: (context) {
                    return [
                      // In this case, we need 5 popupmenuItems one for each option.
                      PopupMenuItem(child: const Text('Edit'), onTap: () {}),
                      PopupMenuItem(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: ColorConstants.colorRed),
                          ),
                          onTap: () async {
                            final currentNoOfCapacity =
                                userController.user!.noOfBeds;
                            print(currentNoOfCapacity);
                            print(roomDetailes.id);
                            await Provider.of<RoomsController>(context,
                                    listen: false)
                                .deleteRoom(
                                    id: roomDetailes.id!,
                                    context: context,
                                    currentCapacity: currentNoOfCapacity,
                                    roomCapacity: roomDetailes.capacity);
                          }),
                    ];
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
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
                        roomDetailes.roomNo.toString(),
                        style: TextStyleConstants.OwnerRoomNumber3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ColorConstants.primaryWhiteColor),
                        padding: const EdgeInsets.only(right: 15),
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
                              "  ${roomDetailes.rent}",
                              style: TextStyleConstants.dashboardBookingName,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ColorConstants.primaryWhiteColor),
                        padding: const EdgeInsets.only(right: 15),
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
                              roomDetailes.capacity.toString(),
                              style: TextStyleConstants.dashboardVacentRoom1,
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ColorConstants.primaryWhiteColor),
                        padding: const EdgeInsets.only(right: 15),
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
                              roomDetailes.vacancy.toString(),
                              style: TextStyleConstants.dashboardVacentRoom1,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
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
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(roomDetailes.facilities.length,
                          (index) {
                        final facilityIndex = roomDetailes.facilities[index];
                        return FacilitiesCard(
                          name: controller.facilitiesList[facilityIndex]
                              ["Facility"]!,
                          icon: controller.facilitiesList[facilityIndex]
                              ["Image"]!,
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
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
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) =>
                          const ResidentsNameCard(),
                      separatorBuilder: (context, index) => const Divider(
                            height: 10,
                          ),
                      itemCount: roomDetailes.residents.length),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

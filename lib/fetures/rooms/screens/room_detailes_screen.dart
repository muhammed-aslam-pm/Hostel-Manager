import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_management_app/fetures/rooms/controllers/rooms_controller.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_controller.dart';
import 'package:hostel_management_app/fetures/rooms/models/room_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/fetures/residents/screens/resident_deatailes_screen.dart';
import 'package:hostel_management_app/fetures/rooms/widgets/room_facilities_card.dart';
import 'dart:ui' as ui;
import 'package:hostel_management_app/fetures/rooms/widgets/residents_name_card.dart';
import 'package:hostel_management_app/fetures/rooms/widgets/residents_name_loading.dart';
import 'package:hostel_management_app/fetures/rooms/screens/rooms_adding_form.dart';
import 'package:provider/provider.dart';

class RoomsViewScreen extends StatefulWidget {
  const RoomsViewScreen(
      {super.key,
      required this.roomDetailes,
      required this.index,
      required this.isVacantRoom});
  final RoomModel roomDetailes;
  final int index;
  final bool isVacantRoom;
  @override
  State<RoomsViewScreen> createState() => _RoomsViewScreenState();
}

class _RoomsViewScreenState extends State<RoomsViewScreen> {
  @override
  void initState() {
    if (widget.roomDetailes.residents.isNotEmpty) {
      fetchResidents();
    }
    super.initState();
  }

  fetchResidents() async {
    await Provider.of<RoomsController>(context, listen: false)
        .fetchResidents(widget.roomDetailes.residents);
  }

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
          child: Consumer<RoomsController>(
            builder: (context, value, child) {
              RoomModel room = widget.isVacantRoom
                  ? value.vacantRooms[widget.index]
                  : value.rooms[widget.index];
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await Provider.of<RoomsController>(context,
                                listen: false)
                            .clearResidents();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: ColorConstants.primaryWhiteColor,
                      )),
                  actions: [
                    PopupMenuButton(
                      iconColor: ColorConstants.primaryWhiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                              child: const Text('Edit'),
                              onTap: () {
                                Provider.of<RoomsController>(context,
                                        listen: false)
                                    .onEditTap(
                                  room: room,
                                );

                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: const RoomsAddingForm(),
                                  ),
                                  elevation: 10,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                  ),
                                  useSafeArea: true,
                                );
                              }),
                          PopupMenuItem(
                            child: Text(
                              'Delete',
                              style: TextStyle(color: ColorConstants.colorRed),
                            ),
                            onTap: () async {
                              final currentNoOfCapacity =
                                  userController.user!.noOfBeds;
                              final currentNoOfVacancy =
                                  userController.user!.noOfVacancy;

                              await Provider.of<RoomsController>(context,
                                      listen: false)
                                  .deleteRoom(
                                      context: context,
                                      currentCapacity: currentNoOfCapacity,
                                      currentVacancy: currentNoOfVacancy,
                                      room: room);
                            },
                          ),
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
                            tag: room.roomNo.toString(),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                    ColorConstants.primaryWhiteColor,
                                child: Icon(
                                  FluentIcons.conference_room_48_regular,
                                  size: 37,
                                  color: ColorConstants.primaryBlackColor,
                                )),
                          ),
                          Hero(
                            tag: "roomNo",
                            child: Text(
                              "Room No",
                              style: TextStyleConstants.ownerRoomNumber2,
                            ),
                          ),
                          Text(
                            room.roomNo.toString(),
                            style: TextStyleConstants.ownerRoomNumber3,
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
                                  child: FaIcon(
                                    FontAwesomeIcons.indianRupeeSign,
                                    color: ColorConstants.primaryBlackColor,
                                  ),
                                ),
                                Text(
                                  "  ${room.rent}",
                                  style:
                                      TextStyleConstants.dashboardBookingName,
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
                                borderRadius: BorderRadius.circular(22),
                                color: ColorConstants.primaryWhiteColor),
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor:
                                      ColorConstants.bedCircleAvtarColor,
                                  child: Icon(
                                    FluentIcons.bed_20_regular,
                                    size: 29,
                                    color: ColorConstants.primaryBlackColor,
                                  ),
                                ),
                                Text(
                                  "  Total Bed : ",
                                  style: TextStyleConstants.ownerRoomsText2,
                                ),
                                Text(
                                  room.capacity.toString(),
                                  style:
                                      TextStyleConstants.dashboardVacentRoom1,
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: ColorConstants.primaryWhiteColor),
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor:
                                      ColorConstants.bedCircleAvtarColor,
                                  child: Icon(
                                    FluentIcons.bed_20_regular,
                                    size: 29,
                                    color: ColorConstants.primaryBlackColor,
                                  ),
                                ),
                                Text(
                                  "  Vacant Bed : ",
                                  style: TextStyleConstants.ownerRoomsText2,
                                ),
                                Text(
                                  room.vacancy.toString(),
                                  style:
                                      TextStyleConstants.dashboardVacentRoom1,
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
                            style: TextStyleConstants.ownerRoomNumber2,
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
                          children:
                              List.generate(room.facilities.length, (index) {
                            final facilityIndex = room.facilities[index];
                            return RoomFacilitiesCard(
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
                            style: TextStyleConstants.ownerRoomNumber2,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<RoomsController>(
                        builder: (context, value, child) => room
                                .residents.isNotEmpty
                            ? value.isResidentLoading
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (context, index1) {
                                      return const ResidentsNameLoading();
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 10,
                                        ),
                                    itemCount: room.capacity)
                                : ListView.separated(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (context, index1) {
                                      return ResidentsNameCard(
                                        name: value.residents![index1].name,
                                        image:
                                            value.residents![index1].profilePic,
                                        phoneNo: value.residents![index1].phone,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ResidentDetailesScreen(
                                                      residentId: value
                                                          .residents![index1]
                                                          .id!),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 10,
                                        ),
                                    itemCount: room.residents.length)
                            : const Center(
                                child: Text("No Resdients on this room"),
                              ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

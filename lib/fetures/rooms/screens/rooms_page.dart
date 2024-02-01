import 'package:flutter/material.dart';
import 'package:hostel_management_app/commens/widgets/custom_dropdown_button.dart';
import 'package:hostel_management_app/fetures/rooms/controllers/rooms_controller.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_controller.dart';
import 'package:hostel_management_app/fetures/rooms/widgets/rooms_loading_card.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/commens/widgets/room_card.dart';
import 'package:hostel_management_app/fetures/rooms/screens/room_detailes_screen.dart';
import 'package:hostel_management_app/fetures/rooms/screens/rooms_adding_form.dart';
import 'package:provider/provider.dart';

class OwnerRoomsPage extends StatefulWidget {
  const OwnerRoomsPage({super.key});

  @override
  State<OwnerRoomsPage> createState() => _OwnerRoomsPageState();
}

class _OwnerRoomsPageState extends State<OwnerRoomsPage> {
  @override
  void initState() {
    Provider.of<RoomsController>(context, listen: false).fetchRoomsData();
    Provider.of<UserController>(context, listen: false).fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RoomsController>(
      context,
    );
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      appBar: AppBar(
        title: Text(
          "Rooms",
          style: TextStyleConstants.homeMainTitle2,
        ),
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 0,
        leadingWidth: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Consumer<RoomsController>(
                      builder: (context, value, child) => CustomDropdownButton(
                          selectedValue: value.selctedFilter,
                          items: value.filters,
                          onChanged: (p0) => value.selectFilter(p0),
                          height: 50,
                          width: MediaQuery.sizeOf(context).width * 0.37),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Consumer<UserController>(
                    builder: (context, value, child) => Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total Beds',
                              style: TextStyleConstants.ownerRoomsText2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  ColorConstants.roomsCircleAvatarColor,
                              child: Text(
                                value.user?.noOfBeds.toString() ?? "0",
                                style: TextStyleConstants
                                    .ownerRoomsCircleAvtarText,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              'Total Beds vaccent',
                              style: TextStyleConstants.ownerRoomsText2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: ColorConstants.primaryColor,
                              child: Text(
                                value.user?.noOfVacancy.toString() ?? "0",
                                style: TextStyleConstants
                                    .ownerRoomsCircleAvtarText,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Consumer<RoomsController>(
              builder: (context, value, child) => Expanded(
                child: value.isRoomsLoading
                    ? GridView.builder(
                        itemCount:
                            value.rooms.isEmpty ? 15 : controller.rooms.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 25,
                          mainAxisExtent: 95,
                        ),
                        itemBuilder: (context, index) =>
                            const RoomsLoadingCard(),
                      )
                    : value.rooms.isEmpty
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("No Rooms Added yet")],
                          )
                        : GridView.builder(
                            itemCount: value.rooms.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 25,
                              mainAxisExtent: 95,
                            ),
                            itemBuilder: (context, index) {
                              final room = value.rooms[index];

                              return RoomsCard(
                                roomNumber: room.roomNo.toString(),
                                vaccentBedNumber: room.vacancy.toString(),
                                onTap: () {
                                  showAdaptiveDialog(
                                      context: context,
                                      builder: (context) => RoomsViewScreen(
                                            roomDetailes: room,
                                            index: index,
                                            isVacantRoom: false,
                                          ),
                                      barrierColor: Colors.transparent);
                                },
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const RoomsAddingForm(),
            ),
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            useSafeArea: true,
          );
        },
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 20,
        child: Icon(
          Icons.add,
          color: ColorConstants.primaryColor,
          size: 30,
        ),
      ),
    );
  }
}

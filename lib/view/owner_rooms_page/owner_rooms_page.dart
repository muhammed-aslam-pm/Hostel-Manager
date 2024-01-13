import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/rooms/rooms_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/date_sorting_button.dart';
import 'package:hostel_management_app/view/global_widgets/room_card.dart';
import 'package:hostel_management_app/view/room_detailes_screen/rooms_view_page.dart';
import 'package:hostel_management_app/view/rooms_adding_form/rooms_adding_form.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DateSortingButton(
                  title: "Floor 1",
                ),
                Row(
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
                            "56",
                            style: TextStyleConstants.ownerRoomsCircleAvtarText,
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
                            "10",
                            style: TextStyleConstants.ownerRoomsCircleAvtarText,
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),

            GridView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: controller.rooms.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 25,
                mainAxisExtent: 95,
              ),
              itemBuilder: (context, index) {
                final room = controller.rooms[index];

                return RoomsCard(
                  roomNumber: room.roomNo.toString(),
                  vaccentBedNumber: room.vacancy.toString(),
                  onTap: () {
                    showAdaptiveDialog(
                        context: context,
                        builder: (context) =>
                            RoomsViewScreen(roomDetailes: room),
                        barrierColor: Colors.transparent);
                  },
                );
              },
            ),

            // Expanded(
            //   child: StreamBuilder(
            //     stream: controller.roomsCollection.snapshots(),
            //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //       if (snapshot.hasError) {
            //         return Center(
            //           child: Text("Error: ${snapshot.error}"),
            //         );
            //       }

            //       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            //         return const Center(
            //           child: Text("No Rooms Data Available"),
            //         );
            //       }

            //       List<RoomModel> roomsList = snapshot.data!.docs
            //           .map((document) {
            //             return RoomModel.fromSnapshot(
            //                 document as DocumentSnapshot<Map<String, dynamic>>);
            //           })
            //           .toList()
            //           .cast<RoomModel>(); // Explicit casting here

            //       // Sort roomsList based on roomNo in ascending order
            //       roomsList.sort((a, b) => a.roomNo.compareTo(b.roomNo));

            //       return GridView.builder(
            //         itemCount: roomsList.length,
            //         gridDelegate:
            //             const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 3,
            //           crossAxisSpacing: 5,
            //           mainAxisSpacing: 25,
            //           mainAxisExtent: 95,
            //         ),
            //         itemBuilder: (context, index) {
            //           final room = roomsList[index];
            //           print(room);
            //           return RoomsCard(
            //             roomNumber: room.roomNo.toString(),
            //             vaccentBedNumber: room.vacancy.toString(),
            //             onTap: () {
            //               showAdaptiveDialog(
            //                   context: context,
            //                   builder: (context) =>
            //                       RoomsViewScreen(roomDetailes: room),
            //                   barrierColor: Colors.transparent);
            //             },
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
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

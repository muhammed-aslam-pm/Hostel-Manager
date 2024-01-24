import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/bookings/bookings_controller.dart';
import 'package:hostel_management_app/controller/users/user_controller.dart';
import 'package:hostel_management_app/model/room_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/room_card.dart';
import 'package:hostel_management_app/view/room_detailes_screen/room_detailes_screen.dart';
import 'package:provider/provider.dart';

class VacantBedsScreen extends StatefulWidget {
  const VacantBedsScreen({super.key});

  @override
  State<VacantBedsScreen> createState() => _VacantBedsScreenState();
}

class _VacantBedsScreenState extends State<VacantBedsScreen> {
  @override
  void initState() {
    Provider.of<BookingsController>(context, listen: false).fetchBookingsData();
    Provider.of<UserController>(context, listen: false).fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BookingsController>(context);
    final userController = Provider.of<UserController>(context);
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      appBar: AppBar(
        title: Text(
          "Vacant beds",
          style: TextStyleConstants.homeMainTitle2,
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                        backgroundColor: ColorConstants.roomsCircleAvatarColor,
                        child: Text(
                          userController.user?.noOfBeds.toString() ?? "",
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
                        ' Beds vaccent',
                        style: TextStyleConstants.ownerRoomsText2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: ColorConstants.primaryColor,
                        child: Text(
                          userController.user?.noOfVacancy.toString() ?? "",
                          style: TextStyleConstants.ownerRoomsCircleAvtarText,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              controller.vacantRooms.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 10, left: 10),
                      itemCount: controller.vacantRooms.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 90,
                      ),
                      itemBuilder: (context, index) {
                        final RoomModel room = controller.vacantRooms[index];
                        return RoomsCard(
                          roomNumber: room.roomNo.toString(),
                          vaccentBedNumber: room.vacancy.toString(),
                          onTap: () {
                            showAdaptiveDialog(
                                context: context,
                                builder: (context) => RoomsViewScreen(
                                      roomDetailes: room,
                                    ),
                                barrierColor: Colors.transparent);
                          },
                        );
                      },
                    )
                  : const Center(
                      child: Text("No Available Vacancies"),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

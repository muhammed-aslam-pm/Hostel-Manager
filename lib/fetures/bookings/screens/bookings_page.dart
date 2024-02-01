import 'package:flutter/material.dart';
import 'package:hostel_management_app/commens/widgets/custom_dropdown_button.dart';
import 'package:hostel_management_app/fetures/bookings/controllers/bookings_controller.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_controller.dart';
import 'package:hostel_management_app/fetures/bookings/models/booking_model.dart';
import 'package:hostel_management_app/fetures/rooms/models/room_model.dart';
import 'package:hostel_management_app/fetures/rooms/widgets/rooms_loading_card.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/fetures/bookings/screens/booked_resident_detailes_screen.dart';
import 'package:hostel_management_app/fetures/bookings/screens/add_booking_screen.dart';
import 'package:hostel_management_app/fetures/bookings/widgets/bookings_card.dart';
import 'package:hostel_management_app/commens/widgets/room_card.dart';
import 'package:hostel_management_app/fetures/bookings/widgets/confirm_delete_dialog.dart';
import 'package:hostel_management_app/fetures/residents/widgets/resident_loading_card.dart';
import 'package:provider/provider.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  @override
  void initState() {
    Provider.of<BookingsController>(context, listen: false).fetchVacantRooms();
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
          "Booking Detailes",
          style: TextStyleConstants.homeMainTitle2,
        ),
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 0,
        leadingWidth: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<BookingsController>(
                      builder: (context, value, child) => CustomDropdownButton(
                          selectedValue: value.selectedFilter,
                          items: value.filters,
                          onChanged: (p0) => value.selectFilter(p0),
                          height: 50,
                          width: 150))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: controller.bookings.length < 3
                    ? MediaQuery.sizeOf(context).height * 30 / 100
                    : MediaQuery.sizeOf(context).height * 45 / 100,
                child: Consumer<BookingsController>(
                  builder: (context, value, child) => value.bookings.isEmpty
                      ? const Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('No available Bookings'),
                            Icon(Icons.error_outline_outlined),
                          ],
                        ))
                      : value.isBookingsLoading
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return const ResidentsLoadingCard();
                              },
                              separatorBuilder: (context, index) => Divider(
                                    color: ColorConstants.secondaryWhiteColor,
                                    height: 10,
                                  ),
                              itemCount: value.bookings.isEmpty
                                  ? 3
                                  : value.bookings.length)
                          : ListView.builder(
                              itemCount: value.bookings.length,
                              itemBuilder: (context, index) {
                                final BookingsModel booking =
                                    value.bookings[index];

                                return BookingsCard(
                                  name: booking.name,
                                  advance: booking.advancePaid,
                                  date: booking.checkIn,
                                  roomNo: booking.roomNO,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookedResidentDetailesScreen(
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                  onDelete: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DeletDialog(
                                          bookingId: booking.id.toString(),
                                          roomId: booking.roomId),
                                    );
                                  },
                                  onEdit: () {
                                    Provider.of<BookingsController>(context,
                                            listen: false)
                                        .onEdit(booking: booking);
                                    showAdaptiveDialog(
                                      barrierColor: Colors.transparent,
                                      context: context,
                                      builder: (context) => AddBookingScreen(
                                        roomNo: booking.roomNO,
                                        roomid: booking.roomId,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Bookings",
                    style: TextStyleConstants.homeMainTitle2,
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
                          userController.user?.noOfVacancy.toString() ?? "",
                          style: TextStyleConstants.ownerRoomsCircleAvtarText,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<BookingsController>(
                builder: (context, value, child) => value.vacantRooms.isNotEmpty
                    ? value.isRoomsLoading
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.only(bottom: 10, left: 10),
                            itemCount: controller.vacantRooms.isEmpty
                                ? 6
                                : controller.vacantRooms.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 20,
                              mainAxisExtent: 90,
                            ),
                            itemBuilder: (context, index) =>
                                const RoomsLoadingCard())
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.only(bottom: 10, left: 10),
                            itemCount: controller.vacantRooms.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 20,
                              mainAxisExtent: 90,
                            ),
                            itemBuilder: (context, index) {
                              final RoomModel room =
                                  controller.vacantRooms[index];
                              return RoomsCard(
                                roomNumber: room.roomNo.toString(),
                                vaccentBedNumber: room.vacancy.toString(),
                                onTap: () {
                                  showAdaptiveDialog(
                                    barrierColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => AddBookingScreen(
                                      roomNo: room.roomNo,
                                      roomid: room.id!,
                                    ),
                                  );
                                },
                              );
                            },
                          )
                    : const Center(
                        child: Text("No Available Vacancies"),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

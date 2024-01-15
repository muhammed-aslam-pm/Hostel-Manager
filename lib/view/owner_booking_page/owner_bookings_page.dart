import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/bookings/bookings_controller.dart';
import 'package:hostel_management_app/model/booking_model.dart';
import 'package:hostel_management_app/model/room_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/booked_resident_detailes_screen/booked_resident_detailes_screen.dart';
import 'package:hostel_management_app/view/global_widgets/date_sorting_button.dart';
import 'package:hostel_management_app/view/booking_form/add_booking_screen.dart';
import 'package:hostel_management_app/view/owner_booking_page/widgets/bookings_card.dart';
import 'package:hostel_management_app/view/global_widgets/room_card.dart';
import 'package:provider/provider.dart';

class OwnerBookingsPage extends StatefulWidget {
  const OwnerBookingsPage({super.key});

  @override
  State<OwnerBookingsPage> createState() => _OwnerBookingsPageState();
}

class _OwnerBookingsPageState extends State<OwnerBookingsPage> {
  @override
  void initState() {
    Provider.of<BookingsController>(context, listen: false).fetchVacantRooms();
    Provider.of<BookingsController>(context, listen: false).fetchBookingsData();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BookingsController>(context);
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [DateSortingButton(title: "This Week")],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 45 / 100,
                child: ListView.builder(
                  itemCount: controller.bookings.length,
                  itemBuilder: (context, index) {
                    final BookingsModel booking = controller.bookings[index];

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
                                BookedResidentDetailesScreen(detailes: booking),
                          ),
                        );
                      },
                      onDelete: () {
                        Provider.of<BookingsController>(context, listen: false)
                            .deleteBooking(
                                context: context,
                                bookingId: booking.id.toString(),
                                roomId: booking.roomId.toString());
                      },
                    );
                  },
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
                        child: Text(
                          "10",
                          style: TextStyleConstants.ownerRoomsCircleAvtarText,
                        ),
                        backgroundColor: ColorConstants.primaryColor,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
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
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) => AddBookingScreen(
                                roomNo: room.roomNo,
                                roomVacancy: room.vacancy,
                                roomid: room.id!,
                              ),
                            );
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

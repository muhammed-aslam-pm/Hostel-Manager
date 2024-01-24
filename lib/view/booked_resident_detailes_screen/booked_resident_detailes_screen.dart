import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/bookings/bookings_controller.dart';
import 'package:hostel_management_app/model/booking_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/booking_form/add_booking_screen.dart';
import 'package:hostel_management_app/view/booking_page/widgets/confirm_delete_dialog.dart';
import 'package:hostel_management_app/view/residents_adding_form/residents_adding_form.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookedResidentDetailesScreen extends StatelessWidget {
  const BookedResidentDetailesScreen(
      {super.key, required this.index, this.isSorted = false});

  final int index;
  final bool? isSorted;

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingsController>(
      builder: (context, value, child) {
        final BookingsModel detailes = isSorted!
            ? value.bookingsWithinThisWeek[index]
            : value.bookings[index];
        return Scaffold(
          backgroundColor: ColorConstants.primaryWhiteColor,
          appBar: AppBar(
            backgroundColor: ColorConstants.primaryWhiteColor,
            iconTheme: IconThemeData(color: ColorConstants.primaryBlackColor),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.chevron_left_outlined,
                  size: 30,
                )),
            actions: [
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: const Text('Edit'),
                        onTap: () {
                          Provider.of<BookingsController>(context,
                                  listen: false)
                              .onEdit(booking: detailes);
                          showAdaptiveDialog(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) => AddBookingScreen(
                              roomNo: detailes.roomNO,
                              roomid: detailes.roomId,
                            ),
                          );
                        }),
                    PopupMenuItem(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: ColorConstants.colorRed),
                      ),
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context1) => DeletDialog(
                              bookingId: detailes.id.toString(),
                              roomId: detailes.roomId),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ];
                },
              ),
            ],
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: ColorConstants.SecondaryColor4,
                      child: const Icon(
                        Icons.person,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorConstants.SecondaryColor4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 4),
                        child: Row(
                          children: [
                            Icon(
                              FluentIcons.conference_room_48_regular,
                              color: ColorConstants.primaryBlackColor,
                              size: 29,
                            ),
                            Text(
                              detailes.roomNO.toString(),
                              style: TextStyleConstants.bookingsRoomNumber,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: detailes.advancePaid
                                ? ColorConstants.colorGreen
                                : ColorConstants.colorRed),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        child: Center(
                          child: Text(
                            detailes.advancePaid
                                ? "Advance Paid"
                                : "Advance Not Paid",
                            style: TextStyleConstants.buttonText,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Name"),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstants.SecondaryColor4.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      detailes.name,
                      style: TextStyleConstants.dashboardBookingName,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Phone Number"),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstants.SecondaryColor4.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          detailes.phoneNo,
                          style: TextStyleConstants.dashboardBookingName,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.call),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Joining Date"),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorConstants.SecondaryColor4.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      DateFormat('dd/MM/yyy').format(detailes.checkIn),
                      style: TextStyleConstants.dashboardBookingName,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context1) => const ResidentsAddingPage(),
                            elevation: 10,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            useSafeArea: true,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstants.primaryColor,
                          ),
                          height: 40,
                          width: 150,
                          child: Center(
                            child: Text(
                              "Add To Residents",
                              style: TextStyleConstants.buttonText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

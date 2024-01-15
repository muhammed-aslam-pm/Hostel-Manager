import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/model/booking_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/booked_resident_detailes_screen/booked_resident_detailes_screen.dart';

class UpcomingBookings extends StatelessWidget {
  const UpcomingBookings(
      {super.key,
      required this.name,
      required this.date,
      required this.roomNumber,
      required this.beadNumber,
      required this.isAdvacePaid});

  final String name;
  final String date;
  final String roomNumber;
  final String beadNumber;
  final bool isAdvacePaid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 10, left: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookedResidentDetailesScreen(
                    detailes: BookingsModel.empty()),
              ));
        },
        child: Container(
          height: 130,
          width: 277,
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          decoration: BoxDecoration(
              color: ColorConstants.primaryWhiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.primaryBlackColor.withOpacity(0.3),
                  blurRadius: 1,
                  offset: Offset(0, 2), // Offset for the bottom shadow
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: ColorConstants.SecondaryColor3,
                        child: Icon(
                          FluentIcons.book_contacts_32_regular,
                          color: ColorConstants.primaryWhiteColor,
                          size: 26,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        name,
                        style: TextStyleConstants.dashboardBookingName,
                      )
                    ],
                  ),
                  Text(
                    date,
                    style: TextStyleConstants.dashboardDate,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Icon(
                        FluentIcons.conference_room_16_regular,
                        color: ColorConstants.primaryBlackColor,
                        size: 26,
                      ),
                      Text(
                        roomNumber,
                        style: TextStyleConstants.dashboardBookinRoomNo,
                      ),
                      Text("Room")
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        FluentIcons.bed_24_regular,
                        color: ColorConstants.primaryBlackColor,
                        size: 26,
                      ),
                      Text(
                        beadNumber,
                        style: TextStyleConstants.dashboardBookinRoomNo,
                      ),
                      Text("Bead")
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        FluentIcons.phone_checkmark_20_regular,
                        color: ColorConstants.primaryBlackColor,
                        size: 26,
                      ),
                      Text(
                        isAdvacePaid ? "Paid" : "Not Paid",
                        style: TextStyleConstants.dashboardBookinRoomNo,
                      ),
                      Text("Advance")
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

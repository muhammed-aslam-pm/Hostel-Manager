import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class UpcomingBookings extends StatelessWidget {
  const UpcomingBookings(
      {super.key,
      required this.name,
      required this.date,
      required this.roomNumber,
      required this.beadNumber,
      required this.isAdvacePaid,
      this.onTap});

  final String name;
  final String date;
  final String roomNumber;
  final String beadNumber;
  final bool isAdvacePaid;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 10, left: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 277,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          decoration: BoxDecoration(
              color: ColorConstants.primaryWhiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.primaryBlackColor.withOpacity(0.3),
                  blurRadius: 1,
                  offset: const Offset(0, 2), // Offset for the bottom shadow
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
                        backgroundColor: ColorConstants.secondaryColor3,
                        child: Icon(
                          FluentIcons.book_contacts_32_regular,
                          color: ColorConstants.primaryWhiteColor,
                          size: 26,
                        ),
                      ),
                      const SizedBox(
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
                      const Text("Room")
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
                      const Text("Bead")
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        isAdvacePaid
                            ? FluentIcons.phone_checkmark_20_regular
                            : FluentIcons.phone_dismiss_20_regular,
                        color: ColorConstants.primaryBlackColor,
                        size: 26,
                      ),
                      Text(
                        isAdvacePaid ? "Paid" : "Not Paid",
                        style: TextStyleConstants.dashboardBookinRoomNo,
                      ),
                      const Text("Advance")
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

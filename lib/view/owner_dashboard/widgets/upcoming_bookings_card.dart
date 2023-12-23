import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

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
                      child: Image.asset(
                        ImageConstants.ownerBookingsIconeDisabled,
                        color: ColorConstants.primaryWhiteColor,
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
                    Image.asset(
                      ImageConstants.ownerRoomsIconeDisabled,
                      color: ColorConstants.primaryBlackColor,
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
                    Container(
                      height: 23,
                      width: 23,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              ImageConstants.beadIcon,
                            ),
                            fit: BoxFit.cover),
                      ),
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
                    Image.asset(
                      ImageConstants.ownerBookingsIconeDisabled,
                      color: ColorConstants.primaryBlackColor,
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
    );
  }
}

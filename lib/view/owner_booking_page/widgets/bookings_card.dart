import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/booked_resident_detailes_screen/booked_resident_detailes_screen.dart';
import 'package:intl/intl.dart';

class BookingsCard extends StatelessWidget {
  const BookingsCard(
      {super.key,
      required this.name,
      required this.date,
      required this.advance,
      required this.roomNo});
  final String name;
  final DateTime date;
  final bool advance;
  final int roomNo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookedResidentDetailesScreen(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Icons.person,
                    color: ColorConstants.primaryWhiteColor,
                  ),
                  backgroundColor: ColorConstants.SecondaryColor4,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      name,
                      style: TextStyleConstants.dashboardBookingName,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 17,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat('dd MMM yyyy').format(date),
                          style: TextStyleConstants.bookingsJoiningDate,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: advance
                              ? ColorConstants.colorGreen.withOpacity(0.6)
                              : ColorConstants.colorRed.withOpacity(0.6)),
                      height: 25,
                      width: 115,
                      child: Center(
                          child: Text(
                              advance ? "Advance Paid" : "Advance Not Paid")),
                    )
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorConstants.SecondaryColor4),
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageConstants.roomsIcon2,
                            color: ColorConstants.primaryBlackColor,
                            height: 25,
                            width: 25,
                          ),
                          Text(
                            roomNo.toString(),
                            style: TextStyleConstants.bookingsRoomNumber,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete))
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

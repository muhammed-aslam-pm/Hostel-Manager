import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/owner_residents_page/resident_deatailes_screen.dart';

class ResidentsDetailescard extends StatelessWidget {
  const ResidentsDetailescard(
      {super.key,
      required this.name,
      required this.joiningDate,
      required this.roomNumber,
      required this.bedNumber,
      required this.isFeePaid});
  final String name;
  final String joiningDate;
  final int roomNumber;
  final int bedNumber;
  final bool isFeePaid;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResidentDetailesScreen(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: ColorConstants.secondaryWhiteColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.primaryBlackColor.withOpacity(0.2),
                blurRadius: 2,
                offset: Offset(0, 4),
              )
            ]),
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
                          "$joiningDate joining",
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
                          color: isFeePaid == true
                              ? ColorConstants.colorGreen.withOpacity(0.6)
                              : ColorConstants.colorRed),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Center(
                          child: isFeePaid == true
                              ? Text("Fees Paid")
                              : Text("Fees Not Paid")),
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
                            roomNumber.toString(),
                            style: TextStyleConstants.bookingsRoomNumber,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorConstants.SecondaryColor4),
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageConstants.bedIcon2,
                            color: ColorConstants.primaryBlackColor,
                            height: 25,
                            width: 25,
                          ),
                          Text(
                            bedNumber.toString(),
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.call,
                    size: 30,
                    color: ColorConstants.primaryColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/shimmer_loader.dart';

class ResidentsDetailescard extends StatelessWidget {
  const ResidentsDetailescard(
      {super.key,
      required this.name,
      required this.joiningDate,
      required this.roomNumber,
      required this.onTap,
      required this.isFeePaid,
      required this.image});
  final String name;
  final String joiningDate;
  final int roomNumber;
  final String image;

  final bool isFeePaid;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                Hero(
                  tag: "profile",
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: ColorConstants.SecondaryColor4,
                    backgroundImage:
                        image.isNotEmpty ? NetworkImage(image) : null,
                    child: image.isEmpty ? Icon(Icons.person) : null,
                  ),
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
                              ? Text(
                                  "Fees Paid",
                                  style: TextStyleConstants.buttonText,
                                )
                              : Text(
                                  "Fees Not Paid",
                                  style: TextStyleConstants.buttonText,
                                )),
                    )
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorConstants.SecondaryColor4),
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        FluentIcons.conference_room_48_regular,
                        color: ColorConstants.primaryBlackColor,
                        size: 27,
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

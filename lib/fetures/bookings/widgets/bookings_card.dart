import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:intl/intl.dart';

class BookingsCard extends StatelessWidget {
  const BookingsCard({
    super.key,
    required this.name,
    required this.date,
    required this.advance,
    required this.roomNo,
    this.onTap,
    required this.onDelete,
    required this.onEdit,
  });
  final String name;
  final DateTime date;
  final bool advance;
  final int roomNo;
  final void Function()? onTap;
  final void Function()? onDelete;
  final void Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: name,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: ColorConstants.secondaryColor4,
                    child: Icon(
                      Icons.person,
                      color: ColorConstants.primaryWhiteColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      name,
                      style: TextStyleConstants.dashboardBookingName,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 17,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat('dd MMM yyyy').format(date),
                          style: TextStyleConstants.bookingsJoiningDate,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: advance
                              ? ColorConstants.colorGreen
                              : ColorConstants.colorRed),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Center(
                          child: Text(
                        advance ? "Advance Paid" : "Advance Not Paid",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorConstants.secondaryColor4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 4),
                      child: Row(
                        children: [
                          Icon(
                            FluentIcons.conference_room_48_regular,
                            color: ColorConstants.primaryBlackColor,
                            size: 26,
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
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => onEdit?.call(),
                        icon: const Icon(FontAwesomeIcons.penToSquare)),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        onPressed: () => onDelete?.call(),
                        icon: const Icon(Icons.delete))
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

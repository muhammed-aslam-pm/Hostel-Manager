import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class GoingToVaccentCard extends StatelessWidget {
  const GoingToVaccentCard(
      {super.key,
      required this.roomNumber,
      required this.beadNumber,
      required this.backgroungColor});

  final String roomNumber;
  final String beadNumber;
  final Color backgroungColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroungColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: ColorConstants.primaryWhiteColor,
                child: Icon(
                  FluentIcons.conference_room_16_regular,
                  color: ColorConstants.primaryBlackColor,
                ),
              ),
              Text(
                "Room No",
                style: TextStyleConstants.upComingVaccencyText1,
              ),
              Text(
                roomNumber,
                style: TextStyleConstants.upComingVaccencyText2,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: ColorConstants.primaryWhiteColor,
                child: Icon(
                  FluentIcons.bed_24_regular,
                  color: ColorConstants.primaryBlackColor,
                  size: 22,
                ),
              ),
              Text(
                "Vacancy",
                style: TextStyleConstants.upComingVaccencyText1,
              ),
              Text(
                beadNumber,
                style: TextStyleConstants.upComingVaccencyText2,
              )
            ],
          ),
        ],
      ),
    );
  }
}

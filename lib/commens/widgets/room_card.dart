import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class RoomsCard extends StatelessWidget {
  const RoomsCard({
    super.key,
    required this.roomNumber,
    required this.vaccentBedNumber,
    this.onTap,
  });
  final String roomNumber;
  final String vaccentBedNumber;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 80,
              width: 83,
              // padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: ColorConstants.secondaryWhiteColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.primaryBlackColor.withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 17,
                  ),
                  Text(
                    "Room No",
                    style: TextStyleConstants.ownerRoomsText2,
                  ),
                  Text(
                    roomNumber,
                    style: TextStyleConstants.ownerRoomNumber,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 30,
            child: Hero(
              tag: roomNumber,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: ColorConstants.secondaryColor4,
                child: Icon(
                  FluentIcons.conference_room_48_regular,
                  color: ColorConstants.primaryBlackColor,
                  size: 27,
                ),
              ),
            ),
          ),
          Visibility(
            visible: vaccentBedNumber == "0" ? false : true,
            child: Positioned(
              top: 0,
              left: 70,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: ColorConstants.primaryColor,
                child: Text(
                  vaccentBedNumber,
                  style: TextStyleConstants.ownerRoomsCircleAvtarText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

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
      child: Container(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 78,
                width: 83,
                padding: EdgeInsets.only(
                  bottom: 6,
                ),
                decoration: BoxDecoration(
                    color: ColorConstants.secondaryWhiteColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color:
                            ColorConstants.primaryBlackColor.withOpacity(0.2),
                        blurRadius: 2,
                        offset: Offset(0, 4),
                      )
                    ]),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Room No",
                        style: TextStyleConstants.ownerRoomsText2,
                      ),
                      Text(
                        roomNumber,
                        style: TextStyleConstants.OwnerRoomNumber,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 5,
                left: 30,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: ColorConstants.SecondaryColor4,
                  child: Image.asset(
                    ImageConstants.ownerRoomsIconeDisabled,
                    color: ColorConstants.primaryBlackColor,
                  ),
                )),
            Positioned(
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
          ],
        ),
      ),
    );
  }
}

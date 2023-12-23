import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/owner_rooms_page/widgets/rooms_view_page.dart';

class RoomsCard extends StatelessWidget {
  const RoomsCard({
    super.key,
    required this.roomNumber,
    required this.vaccentBedNumber,
  });
  final String roomNumber;
  final String vaccentBedNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              child: InkWell(
                onTap: () {
                  showAdaptiveDialog(
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (context) => RoomsViewScreen(
                            roomNumber: roomNumber,
                            numberOfBeds: "6",
                            numberOfVaccentBeds: "2",
                          ));
                },
                child: Container(
                  height: 80,
                  width: 90,
                  padding: EdgeInsets.only(
                    bottom: 2,
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
              )),
          Positioned(
              top: 5,
              left: 30,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: ColorConstants.SecondaryColor4,
                child: Hero(
                  tag: Image,
                  child: Image.asset(
                    ImageConstants.ownerRoomsIconeDisabled,
                    color: ColorConstants.primaryBlackColor,
                  ),
                ),
              )),
          Positioned(
            top: 0,
            left: 80,
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class RoomFacilitiesCard extends StatelessWidget {
  const RoomFacilitiesCard({super.key, required this.name, required this.icon});
  final String name;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: ColorConstants.primaryWhiteColor),
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: ColorConstants.secondaryColor5,
              child: SizedBox(
                  height: 22,
                  width: 22,
                  child: Image.asset(
                    icon,
                    color: ColorConstants.primaryWhiteColor,
                  )),
            ),
            Text(
              "  $name",
              style: TextStyleConstants.dashboardBookingName,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class RoomVaccentCard extends StatelessWidget {
  const RoomVaccentCard(
      {super.key,
      required this.title,
      required this.number,
      required this.bgColor,
      required this.image});

  final String title;
  final String number;
  final Color bgColor;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 17 / 100,
      width: MediaQuery.sizeOf(context).width * 36 / 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: bgColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 17.5,
            backgroundColor: ColorConstants.primaryWhiteColor,
            child: Image.asset(image),
          ),
          Text(
            number,
            style: TextStyleConstants.dashboardVacentRoom1,
          ),
          Text(title, style: TextStyleConstants.dashboardVacentRoom2)
        ],
      ),
    );
  }
}

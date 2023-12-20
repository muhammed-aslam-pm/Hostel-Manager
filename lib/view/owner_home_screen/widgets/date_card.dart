import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';

class DateCard extends StatelessWidget {
  const DateCard({super.key, required this.date});
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 4.5 / 100,
      width: MediaQuery.sizeOf(context).width * 35 / 100,
      padding: EdgeInsets.symmetric(horizontal: 12.5, vertical: 10),
      decoration: BoxDecoration(
          color: ColorConstants.primaryWhiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.primaryBlackColor.withOpacity(0.3),
              blurRadius: 3,
              offset: Offset(0, 3), // Offset for the bottom shadow
            ),
            BoxShadow(
              color: ColorConstants.primaryBlackColor.withOpacity(0.3),
              blurRadius: 3,
              offset: Offset(-2, 0), // Offset for the left shadow
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Image.asset(ImageConstants.calenderIcon), Text(date)],
      ),
    );
  }
}

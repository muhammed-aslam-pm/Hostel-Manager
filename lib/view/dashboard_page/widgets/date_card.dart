import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class DateCard extends StatelessWidget {
  const DateCard({super.key, required this.date});
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.5, vertical: 10),
      decoration: BoxDecoration(
          color: ColorConstants.primaryWhiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.primaryBlackColor.withOpacity(0.3),
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(ImageConstants.calenderIcon),
          Text(
            date,
            style: TextStyleConstants.dashboardDate,
          )
        ],
      ),
    );
  }
}

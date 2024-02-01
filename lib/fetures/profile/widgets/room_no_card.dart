import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({
    super.key,
    required this.title,
    required this.number,
  });

  final String title;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstants.secondaryColor4.withOpacity(0.5)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                ImageConstants.bedIcon2,
                color: ColorConstants.primaryBlackColor,
                height: 25,
                width: 25,
              ),
              Text(
                title,
                style: TextStyleConstants.bookingsRoomNumber,
              )
            ],
          ),
          Text(
            number,
            style: TextStyleConstants.upComingVaccencyText2,
          )
        ],
      ),
    );
  }
}

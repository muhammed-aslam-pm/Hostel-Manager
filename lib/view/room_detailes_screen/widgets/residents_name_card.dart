import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class ResidentsNameCard extends StatelessWidget {
  const ResidentsNameCard({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: ColorConstants.primaryWhiteColor),
      padding: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorConstants.SecondaryColor4,
                  child: Icon(
                    Icons.person,
                    color: ColorConstants.primaryBlackColor,
                  )),
              SizedBox(
                width: 15,
              ),
              Text(
                name,
                style: TextStyleConstants.dashboardBookingName,
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call,
              color: ColorConstants.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}

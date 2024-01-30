import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class DetailesCard extends StatelessWidget {
  const DetailesCard({
    super.key,
    required this.tiltle,
    required this.data,
  });
  final String tiltle;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tiltle),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
              color: ColorConstants.secondaryColor2.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            data,
            style: TextStyleConstants.dashboardBookingName,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

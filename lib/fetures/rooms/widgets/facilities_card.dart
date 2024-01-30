import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class FacilityCard extends StatelessWidget {
  const FacilityCard({
    super.key,
    required this.facility,
    required this.image,
    this.onTap,
    required this.isSelected,
  });
  final String facility;
  final String image;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: ColorConstants.primaryWhiteColor,
              border: Border.all(
                  width: 2,
                  color: isSelected
                      ? ColorConstants.primaryBlackColor
                      : ColorConstants.secondaryColor1)),
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: ColorConstants.secondaryColor5,
                child: SizedBox(
                    height: 22,
                    width: 22,
                    child: Image.asset(
                      image,
                      color: ColorConstants.primaryWhiteColor,
                    )),
              ),
              Text(
                "  $facility",
                style: TextStyleConstants.dashboardBookingName,
              )
            ],
          ),
        ),
      ),
    );
  }
}

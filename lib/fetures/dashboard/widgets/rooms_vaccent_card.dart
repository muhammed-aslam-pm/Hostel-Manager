import 'package:flutter/material.dart';
import 'package:hostel_management_app/commens/widgets/shimmer_loader.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class RoomVaccentCard extends StatelessWidget {
  const RoomVaccentCard(
      {super.key,
      required this.title,
      required this.number,
      required this.bgColor,
      required this.icon,
      required this.onTap,
      this.isLoading = false});

  final String title;
  final String number;
  final Color bgColor;
  final Icon icon;
  final void Function()? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
              child: icon,
            ),
            isLoading
                ? const ShimmerEffect(height: 40, width: 35, radius: 35)
                : Text(
                    number,
                    style: TextStyleConstants.ownerRoomNumber3,
                  ),
            Hero(
                tag: title,
                child:
                    Text(title, style: TextStyleConstants.dashboardVacentRoom2))
          ],
        ),
      ),
    );
  }
}

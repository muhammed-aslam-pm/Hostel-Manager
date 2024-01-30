import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/maintenance_request_detailes_screen/maintenance_request_detailes_screen.dart';

class MaintenanceRequestCard extends StatelessWidget {
  const MaintenanceRequestCard({
    super.key,
    required this.roomNumber,
    required this.complaint1,
    required this.complaint2,
    required this.day,
  });

  final String roomNumber;
  final String complaint1;
  final String complaint2;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MaintenanceRequestDetailesScreen(),
              ));
        },
        child: Container(
          height: 108,
          width: 253,
          decoration: BoxDecoration(
              color: ColorConstants.primaryWhiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.primaryBlackColor.withOpacity(0.3),
                  blurRadius: 1,
                  offset: const Offset(0, 2), // Offset for the bottom shadow
                ),
              ]),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 19,
                    backgroundColor: ColorConstants.secondaryColor4,
                    child: Image.asset(
                      ImageConstants.ownerRoomsIconeDisabled,
                      color: ColorConstants.primaryBlackColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Room No $roomNumber",
                        style: TextStyleConstants.dashboardBookingName,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ImageConstants.complaintIcon,
                          ),
                          Text(
                            complaint1,
                            style: TextStyleConstants.complaintText,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            FluentIcons.phone_chat_24_regular,
                            size: 19,
                          ),
                          Text(
                            complaint2,
                            style: TextStyleConstants.complaintText,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$day d ago",
                    style: TextStyleConstants.complaintText2,
                  ),
                  Image.asset(
                    ImageConstants.upRightArrowIcon,
                    color: ColorConstants.primaryBlackColor,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

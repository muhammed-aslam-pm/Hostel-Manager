import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/commens/widgets/shimmer_loader.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class ResidentsDetailescard extends StatelessWidget {
  const ResidentsDetailescard(
      {super.key,
      required this.name,
      required this.joiningDate,
      required this.roomNumber,
      required this.onTap,
      required this.isFeePaid,
      required this.image});
  final String name;
  final String joiningDate;
  final int roomNumber;
  final String image;
  final bool isFeePaid;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorConstants.secondaryWhiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.primaryBlackColor.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: name,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: ColorConstants.secondaryColor3,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: image.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      const ShimmerEffect(
                                          height: 40, width: 40, radius: 40),
                            )
                          : const Center(
                              child: Icon(Icons.person),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      name,
                      style: TextStyleConstants.dashboardBookingName,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 17,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$joiningDate joining",
                          style: TextStyleConstants.bookingsJoiningDate,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: isFeePaid == true
                              ? ColorConstants.colorGreen.withOpacity(0.6)
                              : ColorConstants.colorRed),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Center(
                        child: isFeePaid == true
                            ? Text(
                                "Fees Paid",
                                style: TextStyleConstants.buttonText,
                              )
                            : Text(
                                "Fees Not Paid",
                                style: TextStyleConstants.buttonText,
                              ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorConstants.secondaryColor4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        FluentIcons.conference_room_48_regular,
                        color: ColorConstants.primaryBlackColor,
                        size: 27,
                      ),
                      Text(
                        roomNumber.toString(),
                        style: TextStyleConstants.bookingsRoomNumber,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(
                  height: 5,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.call,
                    size: 30,
                    color: ColorConstants.primaryColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

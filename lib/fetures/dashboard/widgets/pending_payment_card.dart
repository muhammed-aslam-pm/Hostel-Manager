import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_management_app/fetures/residents/models/resident_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/fetures/payments/screens/pending_payments_screen.dart';

class PendingPaymentCard extends StatelessWidget {
  const PendingPaymentCard({
    super.key,
    required this.roomNumber,
    required this.date,
    required this.amount,
    required this.residents,
  });
  final String roomNumber;
  final String date;
  final String amount;
  final List<ResidentModel> residents;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PendingPaymentsScreen(),
            ));
      },
      child: SizedBox(
        height: 106,
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
                  child: Icon(
                    FluentIcons.door_28_regular,
                    color: ColorConstants.primaryBlackColor,
                    size: 26,
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
                          ImageConstants.calenderIcon,
                        ),
                        Text(
                          "$date due",
                          style: TextStyleConstants.dashboardPendingDue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                      width: 60,
                      child: Stack(
                        children: [
                          Positioned(
                              left: 0,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: residents[0].profilePic == ""
                                    ? null
                                    : NetworkImage(residents[0].profilePic),
                              )),
                          residents.length > 1
                              ? Positioned(
                                  left: 15,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundImage: residents[1].profilePic ==
                                            ""
                                        ? null
                                        : NetworkImage(residents[1].profilePic),
                                  ))
                              : residents.length > 2
                                  ? Positioned(
                                      right: 0,
                                      bottom: 4,
                                      child: Text("+${residents.length - 2}"),
                                    )
                                  : const SizedBox()
                        ],
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
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.indianRupeeSign,
                      color: ColorConstants.primaryBlackColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      amount,
                      style: TextStyleConstants.dashboardPendingMoney,
                    )
                  ],
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
    );
  }
}

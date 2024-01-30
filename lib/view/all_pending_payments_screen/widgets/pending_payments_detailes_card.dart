import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/all_pending_payments_screen/widgets/pyment_name_card.dart';

class PendingPaymentDetailesCard extends StatelessWidget {
  const PendingPaymentDetailesCard({super.key});

  get roomNumber => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorConstants.secondaryColor3,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorConstants.secondaryColor1),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  ImageConstants.roomsIcon2,
                  color: ColorConstants.primaryBlackColor,
                  height: 25,
                  width: 25,
                ),
                Text(
                  "Room No ",
                  style: TextStyleConstants.bookingsRoomNumber,
                ),
                Text(
                  "01",
                  style: TextStyleConstants.bookingsRoomNumber,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Column(
              children: List.generate(4, (index) => const PaymentNameCard()),
            ),
          )
        ],
      ),
    );
  }
}

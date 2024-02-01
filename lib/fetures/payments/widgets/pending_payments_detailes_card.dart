import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/residents/models/resident_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

import 'package:hostel_management_app/fetures/payments/widgets/pyment_name_card.dart';
import 'package:intl/intl.dart';

class PendingPaymentDetailesCard extends StatelessWidget {
  const PendingPaymentDetailesCard(
      {super.key,
      required this.roomNo,
      required this.residents,
      required this.totalAmount});

  final String roomNo;
  final int totalAmount;
  final List<ResidentModel> residents;

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
                  roomNo,
                  style: TextStyleConstants.bookingsRoomNumber,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Column(
              children: List.generate(
                  residents.length,
                  (index) => PaymentNameCard(
                        name: residents[index].name,
                        date: DateFormat('dd MMM')
                            .format(residents[index].nextRentDate),
                        rentAmount: (totalAmount / residents.length).toString(),
                        resident: residents[index],
                      )),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class PentingPaymentNameCard extends StatelessWidget {
  const PentingPaymentNameCard(
      {super.key, required this.name, required this.amount});

  final String name;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: ColorConstants.primaryWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorConstants.primaryColor.withOpacity(0.3),
            child: Icon(
              Icons.person,
              color: ColorConstants.primaryWhiteColor,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            name,
            style: TextStyleConstants.ownerRoomsText2,
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(7),
                    bottomLeft: Radius.circular(7))),
            child: Row(
              children: [
                SizedBox(
                    height: 18,
                    width: 9,
                    child: Image.asset(
                      ImageConstants.moneyIcon,
                      color: ColorConstants.primaryWhiteColor,
                    )),
                SizedBox(
                  width: 4,
                ),
                Text(
                  amount,
                  style: TextStyle(color: ColorConstants.primaryWhiteColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class PendingPaymentDetailesCard extends StatelessWidget {
  const PendingPaymentDetailesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(color: ColorConstants.SecondaryColor1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Room no 1"),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.person,
                              color: ColorConstants.primaryWhiteColor,
                            ),
                            backgroundColor: ColorConstants.SecondaryColor4,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Aslam",
                            style: TextStyleConstants.dashboardBookingName,
                          ),
                        ],
                      ),
                      Text("5750")
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hostel_management_app/model/resident_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/resident_detailes_screen/resident_deatailes_screen.dart';

class PaymentNameCard extends StatelessWidget {
  const PaymentNameCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResidentDetailesScreen(
                  resident: ResidentModel.empty(),
                ),
              ));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstants.primaryWhiteColor),
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
                    backgroundColor:
                        ColorConstants.primaryColor.withOpacity(0.3),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Aslam",
                        style: TextStyleConstants.dashboardBookingName,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ImageConstants.calenderIcon,
                          ),
                          Text(
                            "28 sep due",
                            style: TextStyleConstants.dashboardPendingDue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      height: 18,
                      width: 9,
                      child: Image.asset(
                        ImageConstants.moneyIcon,
                        color: ColorConstants.primaryColor,
                      )),
                  SizedBox(
                    width: 4,
                  ),
                  Text("5750", style: TextStyleConstants.dashboardBookinRoomNo),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

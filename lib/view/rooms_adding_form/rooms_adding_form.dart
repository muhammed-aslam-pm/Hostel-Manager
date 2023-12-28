import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class RoomsAddingForm extends StatelessWidget {
  const RoomsAddingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "No of Beds",
            style: TextStyleConstants.dashboardBookingName,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 1.5, color: ColorConstants.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(width: 2, color: ColorConstants.primaryColor),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Rent",
            style: TextStyleConstants.dashboardBookingName,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 1.5, color: ColorConstants.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(width: 2, color: ColorConstants.primaryColor),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Facilities : ",
            style: TextStyleConstants.dashboardBookingName,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: ColorConstants.primaryWhiteColor,
                      border: Border.all(
                          width: 2, color: ColorConstants.primaryBlackColor)),
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: ColorConstants.SecondaryColor5,
                        child: SizedBox(
                            height: 22,
                            width: 22,
                            child: Image.asset(
                              ImageConstants.ACIcon,
                              color: ColorConstants.primaryWhiteColor,
                            )),
                      ),
                      Text(
                        "  A/C",
                        style: TextStyleConstants.dashboardBookingName,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: ColorConstants.primaryWhiteColor,
                      border: Border.all(
                          width: 2, color: ColorConstants.primaryBlackColor)),
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: ColorConstants.SecondaryColor5,
                        child: SizedBox(
                            height: 22,
                            width: 22,
                            child: Image.asset(
                              ImageConstants.washingMachineIcon,
                              color: ColorConstants.primaryWhiteColor,
                            )),
                      ),
                      Text(
                        "  Washing Machine",
                        style: TextStyleConstants.dashboardBookingName,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: ColorConstants.primaryWhiteColor,
                      border: Border.all(
                          width: 2, color: ColorConstants.primaryBlackColor)),
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: ColorConstants.SecondaryColor5,
                        child: SizedBox(
                            height: 22,
                            width: 22,
                            child: Image.asset(
                              ImageConstants.ACIcon,
                              color: ColorConstants.primaryWhiteColor,
                            )),
                      ),
                      Text(
                        "  Attached Bathroom",
                        style: TextStyleConstants.dashboardBookingName,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: ColorConstants.primaryWhiteColor,
                      border: Border.all(
                          width: 2, color: ColorConstants.primaryBlackColor)),
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: ColorConstants.SecondaryColor5,
                        child: SizedBox(
                            height: 22,
                            width: 22,
                            child: Image.asset(
                              ImageConstants.wifiIcon,
                              color: ColorConstants.primaryWhiteColor,
                            )),
                      ),
                      Text(
                        "  WiFi",
                        style: TextStyleConstants.dashboardBookingName,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.primaryColor,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Center(
                    child: Text(
                      " Cancel",
                      style: TextStyleConstants.buttonText,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.primaryColor,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Center(
                    child: Text(
                      "Add ",
                      style: TextStyleConstants.buttonText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

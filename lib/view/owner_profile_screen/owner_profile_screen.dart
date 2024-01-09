import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/authentications/login_screen.dart';

class OwnerProfileScreen extends StatelessWidget {
  const OwnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryWhiteColor,
        iconTheme: IconThemeData(color: ColorConstants.primaryBlackColor),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left_outlined,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false);
              },
              icon: Icon(Icons.more_vert_rounded))
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "profile",
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: ColorConstants.SecondaryColor4,
                  child: Icon(Icons.person),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.SecondaryColor1,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Sunnys Gents Hostel",
                  style: TextStyleConstants.dashboardBookingName,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Address"),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.SecondaryColor1,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "somthing........ Somthing..............................",
                  style: TextStyleConstants.dashboardBookingName,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Owner Name"),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.SecondaryColor1,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Veena",
                  style: TextStyleConstants.dashboardBookingName,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Phone Number"),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.SecondaryColor1,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "+91-1234567890",
                  style: TextStyleConstants.dashboardBookingName,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Email"),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.SecondaryColor1,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "akskjdkj@gmail.com",
                  style: TextStyleConstants.dashboardBookingName,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorConstants.SecondaryColor4),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              ImageConstants.bedIcon2,
                              color: ColorConstants.primaryBlackColor,
                              height: 25,
                              width: 25,
                            ),
                            Text(
                              "No of Rooms",
                              style: TextStyleConstants.bookingsRoomNumber,
                            )
                          ],
                        ),
                        Text(
                          "18",
                          style: TextStyleConstants.upComingVaccencyText2,
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorConstants.SecondaryColor4),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              ImageConstants.bedIcon2,
                              color: ColorConstants.primaryBlackColor,
                              height: 25,
                              width: 25,
                            ),
                            Text(
                              "No of Beds",
                              style: TextStyleConstants.bookingsRoomNumber,
                            )
                          ],
                        ),
                        Text(
                          "33",
                          style: TextStyleConstants.upComingVaccencyText2,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

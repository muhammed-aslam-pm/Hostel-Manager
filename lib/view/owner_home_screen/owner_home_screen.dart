import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/owner_bottom_navbar_controller/owner_bottom_navbar_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:provider/provider.dart';

class OwnerHomeScreen extends StatelessWidget {
  const OwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OwnerNavBarController navBarController =
        Provider.of<OwnerNavBarController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Welcom Back,",
              style: TextStyleConstants.homeMainTitle1,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Asha",
              style: TextStyleConstants.homeMainTitle2,
            )
          ],
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(ImageConstants.ownerHomeProfilePhoto),
          ),
          SizedBox(
            width: 30,
          ),
        ],
        titleSpacing: -20,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 140,
                width: 135,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorConstants.SecondaryColor2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 17.5,
                      backgroundColor: ColorConstants.primaryWhiteColor,
                    ),
                    Text(
                      "24",
                      style: TextStyleConstants.dashboardVacentRoom1,
                    ),
                    Text("Rooms Vacant",
                        style: TextStyleConstants.dashboardVacentRoom2)
                  ],
                ),
              ),
              Container(
                height: 140,
                width: 135,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorConstants.primaryWhiteColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 17.5,
                      backgroundColor: ColorConstants.primaryWhiteColor,
                    ),
                    Text(
                      "24",
                      style: TextStyleConstants.dashboardVacentRoom1,
                    ),
                    Text("Rooms Vacant",
                        style: TextStyleConstants.dashboardVacentRoom2)
                  ],
                ),
              )
            ],
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navBarController.selectedIndex,
        onTap: (value) {
          Provider.of<OwnerNavBarController>(context, listen: false)
              .onNavTap(value);
        },
        selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: ColorConstants.primaryBlackColor),
        selectedItemColor: ColorConstants.primaryBlackColor,
        unselectedItemColor: ColorConstants.primaryBlackColor,
        unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ColorConstants.primaryBlackColor),
        unselectedIconTheme:
            IconThemeData(size: 30, color: ColorConstants.primaryBlackColor),
        selectedIconTheme:
            IconThemeData(size: 30, color: ColorConstants.primaryBlackColor),
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                navBarController.selectedIndex == 0
                    ? ImageConstants.ownerDashboardIconeEnabled
                    : ImageConstants.ownerDashboardIconeDisabled,
                height: 30,
                width: 30,
                color: ColorConstants.primaryBlackColor,
              ),
              label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Image.asset(
                navBarController.selectedIndex == 1
                    ? ImageConstants.ownerRoomsIconeEnabled
                    : ImageConstants.ownerRoomsIconeDisabled,
                height: 30,
                width: 30,
                color: ColorConstants.primaryBlackColor,
              ),
              label: 'Rooms'),
          BottomNavigationBarItem(
              icon: Image.asset(
                navBarController.selectedIndex == 2
                    ? ImageConstants.ownerBookingsIconeEnabled
                    : ImageConstants.ownerBookingsIconeDisabled,
                height: 30,
                width: 30,
                color: ColorConstants.primaryBlackColor,
              ),
              label: 'Bookings'),
          BottomNavigationBarItem(
              icon: Image.asset(
                navBarController.selectedIndex == 3
                    ? ImageConstants.ownerResidetsIconeEnabled
                    : ImageConstants.ownerResidentsIconeDisabled,
                height: 30,
                width: 30,
                color: ColorConstants.primaryBlackColor,
              ),
              label: 'Residents'),
        ],
      ),
    );
  }
}
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/owner_bottom_navbar_controller/owner_bottom_navbar_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/owner_home_screen/widgets/date_card.dart';
import 'package:hostel_management_app/view/owner_home_screen/widgets/date_sorting_button.dart';
import 'package:hostel_management_app/view/owner_home_screen/widgets/rooms_vaccent_card.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 11 / 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoomVaccentCard(
                      title: "Rooms Vacentnt",
                      number: "24",
                      bgColor: ColorConstants.SecondaryColor2,
                      image: ImageConstants.ownerRoomsIconeDisabled),
                  RoomVaccentCard(
                      title: "Paymenys penting",
                      number: "12",
                      bgColor: ColorConstants.SecondaryColor1,
                      image: ImageConstants.ownerRoomsIconeDisabled),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Going to vaccent",
                style: TextStyleConstants.dashboardSubtitle1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17, left: 20),
              child: Row(
                children: [
                  DateSortingButton(),
                  SizedBox(
                    width: 18.6,
                  ),
                  DateCard(date: "12/12/2023")
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) => Container(
                  height: 770,
                  width: 153,
                  color: Colors.amber,
                ),
              ),
            )
          ],
        ),
      ),
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
            label: 'Residents',
          ),
        ],
      ),
    );
  }
}

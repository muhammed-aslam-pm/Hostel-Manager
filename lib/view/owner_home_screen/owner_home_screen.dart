import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/owner_bottom_navbar_controller/owner_bottom_navbar_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:provider/provider.dart';

class OwnerHomeScreen extends StatelessWidget {
  const OwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OwnerNavBarController navBarController =
        Provider.of<OwnerNavBarController>(context);
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      body: Provider.of<OwnerNavBarController>(context).ownerPages[
          Provider.of<OwnerNavBarController>(context).selectedIndex],
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

import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/fetures/authentication/screens/login_screen.dart';

class OnBoardingController with ChangeNotifier {
  PageController pageController = PageController();

  List<Map> onBoardingScreens = [
    {
      "image": ImageConstants.onBoardingImage1,
      "title1": "Your",
      "title2": "Comfort Zone Awaits!",
      "description":
          "Discover the ease of room reservations, seamless communication, and a vibrant community."
    },
    {
      "image": ImageConstants.onBoardingImage2,
      "title1": "Elevate Your Hostel",
      "title2": "Experience",
      "description":
          "Immerse yourself in a new era of hostel living. From intuitive bookings to community engagement, our hostel management system redefines convenience."
    },
    {
      "image": ImageConstants.onBoardingImage3,
      "title1": "Unlock a",
      "title2": "World of Possibilities",
      "description":
          "Our hostel management system opens the gateway to seamless living, vibrant events, and lasting connections."
    }
  ];

  String title1 = "Your";
  String title2 = "Comfort Zone Awaits!";
  String description =
      "Discover the ease of room reservations, seamless communication, and a vibrant community.";
//------------------------------------------------------------------------------On page change function
  onPageChange({required int index}) {
    title1 = onBoardingScreens[index]["title1"];
    title2 = onBoardingScreens[index]["title2"];
    description = onBoardingScreens[index]["description"];

    notifyListeners();
  }
//------------------------------------------------------------------------------On smooth indicator dot click
  onDotClicked(index) {
    pageController.jumpToPage(index);
    notifyListeners();
  }

  onTap(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

 
}

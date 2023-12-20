import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';

class TextStyleConstants {
  //on boarding screen styles
  static TextStyle onboardText1 = TextStyle(
      fontSize: 25,
      color: ColorConstants.primaryColor,
      fontWeight: FontWeight.w700);

  static TextStyle onboardText2 = TextStyle(
      fontSize: 14,
      color: ColorConstants.primaryBlackColor,
      fontWeight: FontWeight.w400);

  static TextStyle onBoardButtonText = TextStyle(
      fontSize: 15,
      color: ColorConstants.primaryWhiteColor,
      fontWeight: FontWeight.w500);

  //homescreen styles

  static TextStyle homeMainTitle1 = TextStyle(
      fontSize: 19.6,
      color: ColorConstants.primaryColor,
      fontWeight: FontWeight.w400);

  static TextStyle homeMainTitle2 = TextStyle(
      fontSize: 23.5,
      color: ColorConstants.primaryColor,
      fontWeight: FontWeight.w600);

  static TextStyle dashboardVacentRoom1 = TextStyle(
      fontSize: 30,
      color: ColorConstants.primaryColor,
      fontWeight: FontWeight.w900);

  static TextStyle dashboardVacentRoom2 = TextStyle(
      fontSize: 15,
      color: ColorConstants.primaryWhiteColor,
      fontWeight: FontWeight.w600);

  static TextStyle dashboardSubtitle1 = TextStyle(
      fontSize: 17,
      color: ColorConstants.primaryColor,
      fontWeight: FontWeight.w700);
}

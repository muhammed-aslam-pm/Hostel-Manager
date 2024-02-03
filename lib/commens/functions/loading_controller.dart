import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/animation_constants.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:lottie/lottie.dart';

class FullScreenLoader {
  static Future openLoadinDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context1) => Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorConstants.primaryWhiteColor,
        padding: const EdgeInsets.all(40),
        child: Center(
          child: LottieBuilder.asset(
            AnimationConstants.loading,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  static stopLoadin(BuildContext context) {
    Navigator.of(context).pop();
  }
}

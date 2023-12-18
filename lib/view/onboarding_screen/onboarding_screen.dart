import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/onBordingControllers/custom_clipper.dart';
import 'package:hostel_management_app/utils/image_constants.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        color: Colors.amber,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 2 / 3,
                child: PageView(
                  children: [
                    Image.asset(
                      ImageConstants.onBoardingImage1,
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      ImageConstants.onBoardingImage2,
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      ImageConstants.onBoardingImage3,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.sizeOf(context).height * 55 / 100,
                child: ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 50 / 100,
                    color: Colors.white, // Container color
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

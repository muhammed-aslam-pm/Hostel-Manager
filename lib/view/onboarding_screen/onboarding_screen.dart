import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/onBordingControllers/custom_clipper.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
                  controller: pageController,
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
              top: MediaQuery.sizeOf(context).height * 50 / 100,
              child: ClipPath(
                clipper: MyCustomClipper(),
                child: Container(
                  padding: EdgeInsets.all(30),
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 50 / 100,
                  color: ColorConstants.primaryWhiteColor,
                  child: Column(children: [
                    SizedBox(
                      height: 55,
                    ),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: ColorConstants.primaryColor,
                        dotColor: ColorConstants.SecondaryColor1,
                        dotHeight: 5,
                        dotWidth: 10.5,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

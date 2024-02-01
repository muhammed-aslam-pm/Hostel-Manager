import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/authentication/widgets/custom_clipper.dart';
import 'package:hostel_management_app/fetures/authentication/controllers/onboarding/onboaring_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    OnBoardingController onBoardingController =
        Provider.of<OnBoardingController>(context);
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        color: ColorConstants.primaryWhiteColor,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 2 / 3,
                child: PageView(
                  onPageChanged: (value) {
                    Provider.of<OnBoardingController>(context, listen: false)
                        .onPageChange(index: value);
                  },
                  padEnds: true,
                  controller: onBoardingController.pageController,
                  children: List.generate(
                    onBoardingController.onBoardingScreens.length,
                    (index) => Image.asset(
                      onBoardingController.onBoardingScreens[index]['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 50 / 100,
              child: ClipPath(
                clipper: MyCustomClipper(),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 50 / 100,
                  color: ColorConstants.primaryWhiteColor,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 55,
                      ),
                      SmoothPageIndicator(
                        controller: onBoardingController.pageController,
                        count: 3,
                        onDotClicked: (index) =>
                            Provider.of<OnBoardingController>(context,
                                    listen: false)
                                .onDotClicked(index),
                        effect: ExpandingDotsEffect(
                          activeDotColor: ColorConstants.primaryColor,
                          dotColor: ColorConstants.secondaryColor1,
                          dotHeight: 5,
                          dotWidth: 10.5,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 80 / 100,
                        child: Column(
                          children: [
                            SizedBox(
                              width:
                                  MediaQuery.sizeOf(context).width * 65 / 100,
                              height:
                                  MediaQuery.sizeOf(context).height * 10 / 100,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    onBoardingController.title1,
                                    style: TextStyleConstants.onboardText1,
                                  ),
                                  Text(
                                    onBoardingController.title2,
                                    style: TextStyleConstants.onboardText1,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: Text(
                                onBoardingController.description,
                                style: TextStyleConstants.onboardText2,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () => Provider.of<OnBoardingController>(
                                    context,
                                    listen: false)
                                .onTap(context),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorConstants.primaryColor,
                              ),
                              height: 40,
                              width: 150,
                              child: Center(
                                child: Text(
                                  "Get now",
                                  style: TextStyleConstants.buttonText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

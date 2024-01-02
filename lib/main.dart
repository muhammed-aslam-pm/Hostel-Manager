import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/account_setup_screen_controller/account_setup_screen_controller.dart';
import 'package:hostel_management_app/controller/onBordingControllers/onboaring_controller.dart';
import 'package:hostel_management_app/controller/owner_bottom_navbar_controller/owner_bottom_navbar_controller.dart';
import 'package:hostel_management_app/controller/residents_controller/residents_controller.dart';
import 'package:hostel_management_app/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OnBoardingController(),
        ),
        ChangeNotifierProvider(
          create: (context) => OwnerNavBarController(),
        ),
        ChangeNotifierProvider(
          create: (context) => residentsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccountSetUpScreenController(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

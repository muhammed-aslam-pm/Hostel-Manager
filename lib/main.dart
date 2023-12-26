import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/onBordingControllers/onboaring_controller.dart';
import 'package:hostel_management_app/controller/owner_bottom_navbar_controller/owner_bottom_navbar_controller.dart';
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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

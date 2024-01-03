import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/account_setup_screen_controller/account_setup_screen_controller.dart';
import 'package:hostel_management_app/controller/authentication/signup_controller.dart';
import 'package:hostel_management_app/controller/onboarding/onboaring_controller.dart';
import 'package:hostel_management_app/controller/bottomnavbar/bottomnavbar_controller.dart';
import 'package:hostel_management_app/controller/residents_controller/residents_controller.dart';
import 'package:hostel_management_app/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ),
        ChangeNotifierProvider(
          create: (context) => SignupController(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

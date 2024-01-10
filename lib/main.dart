import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/account_setup_screen_controller/account_setup_screen_controller.dart';
import 'package:hostel_management_app/controller/authentication/authentication_repository.dart';
import 'package:hostel_management_app/controller/authentication/forgotpassword_controller.dart';
import 'package:hostel_management_app/controller/authentication/login_controller.dart';
import 'package:hostel_management_app/controller/authentication/signin_controller.dart';
import 'package:hostel_management_app/controller/dashboard_controller/dashboard_controller.dart';
import 'package:hostel_management_app/controller/onboarding/onboaring_controller.dart';
import 'package:hostel_management_app/controller/bottomnavbar/bottomnavbar_controller.dart';
import 'package:hostel_management_app/controller/residents_controller/residents_controller.dart';
import 'package:hostel_management_app/controller/users/user_controller.dart';
import 'package:hostel_management_app/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBUW30KcgMfmfMr7z6irFLCz9G9Dcv9Amw",
        appId: "1:721358647180:android:8bba875f4f26ea2a8470a9",
        messagingSenderId: '',
        projectId: "hostel-management-app-4ae0f",
        storageBucket: "hostel-management-app-4ae0f.appspot.com"),
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
          create: (context) => SignInController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthenticationRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForgotPasswordController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashboardController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserController(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

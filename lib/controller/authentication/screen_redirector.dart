import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_management_app/view/onboarding_screen/onboarding_screen.dart';
import 'package:hostel_management_app/view/owner_home_screen/owner_home_screen.dart';

class ScreenReDirector {
  static redirectScreen() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const OwnerHomeScreen();
    } else {
      return const OnBoardingScreen();
    }
  }
}

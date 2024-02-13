import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/authentication/controllers/login_controller.dart';
import 'package:hostel_management_app/fetures/authentication/controllers/register_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/fetures/authentication/screens/signup_screen.dart';

import 'package:provider/provider.dart';

import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    Provider.of<LoginController>(context, listen: false)
        .fetchStordCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome \n Back!",
                  style: TextStyleConstants.loginTiltle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                const LoginForm(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        child: const Text("Signup Now"))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 1,
                      color: ColorConstants.colorGrey,
                      width: MediaQuery.sizeOf(context).width * 35 / 100,
                    ),
                    Text(
                      "or",
                      style: TextStyle(color: ColorConstants.colorGrey),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.sizeOf(context).width * 35 / 100,
                      color: ColorConstants.colorGrey,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Provider.of<SignInController>(context, listen: false)
                        .signInWithGoogle(context);
                  },
                  child: Container(
                    height: 47,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    color: ColorConstants.secondaryWhiteColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageConstants.googleLogo),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign in with Google",
                          style: TextStyleConstants.dashboardDate,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/account_setup_screen/account_setup_screen.dart';

class SignUpSuccessfullScree extends StatefulWidget {
  const SignUpSuccessfullScree({super.key});

  @override
  State<SignUpSuccessfullScree> createState() => _SignUpSuccessfullScreeState();
}

class _SignUpSuccessfullScreeState extends State<SignUpSuccessfullScree> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 1)).then(
      (value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountSetupScreen(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: ColorConstants.primaryColor,
                child: Icon(
                  Icons.done,
                  size: 60,
                  color: ColorConstants.primaryWhiteColor,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Text(
                "Sign Up \n Successfull",
                style: TextStyleConstants.loginTiltle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

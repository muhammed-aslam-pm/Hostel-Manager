import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class BokkingsuccessfullScreen extends StatefulWidget {
  const BokkingsuccessfullScreen({super.key});

  @override
  State<BokkingsuccessfullScreen> createState() =>
      _BokkingsuccessfullScreenState();
}

class _BokkingsuccessfullScreenState extends State<BokkingsuccessfullScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then(
      (value) {
        Navigator.pop(context);
        Navigator.pop(context);
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
              const SizedBox(
                height: 70,
              ),
              Text(
                "Booking Added \n Successfully",
                style: TextStyleConstants.loginTiltle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

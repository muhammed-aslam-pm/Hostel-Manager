import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/all_pending_payments_screen/widgets/pending_payments_detailes_card.dart';

class PendingPaymentsScreen extends StatelessWidget {
  const PendingPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: Title,
          child: Text(
            "Pending Payments",
            style: TextStyleConstants.homeMainTitle2,
          ),
        ),
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 0,
        leadingWidth: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            itemBuilder: (context, index) => PendingPaymentDetailesCard(),
            separatorBuilder: (context, index) => Divider(
                  height: 10,
                ),
            itemCount: 10),
      ),
    );
  }
}

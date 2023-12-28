import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: ColorConstants.primaryColor,
            )),
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => PendingPaymentDetailesCard(),
                  separatorBuilder: (context, index) => Divider(
                        height: 10,
                      ),
                  itemCount: 4),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.SecondaryColor3,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total :",
                      style: TextStyleConstants.upComingVaccencyText2,
                    ),
                    Row(
                      children: [
                        SizedBox(
                            height: 30,
                            width: 15,
                            child: Image.asset(
                              ImageConstants.moneyIcon,
                              color: ColorConstants.primaryBlackColor,
                            )),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "5750",
                          style: TextStyleConstants.upComingVaccencyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

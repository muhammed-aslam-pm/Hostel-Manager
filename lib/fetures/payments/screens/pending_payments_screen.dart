import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/dashboard/controllers/dashboard_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/fetures/payments/widgets/pending_payments_detailes_card.dart';
import 'package:provider/provider.dart';

class PendingPaymentsScreen extends StatelessWidget {
  const PendingPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
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
      body: Consumer<DashboardController>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => PendingPaymentDetailesCard(
                          roomNo:
                              value.pendingPayments[index]["RoomNo"].toString(),
                          residents: value.pendingPayments[index]["Residents"],
                          totalAmount: value.pendingPayments[index]
                              ["TotalAmount"],
                        ),
                    separatorBuilder: (context, index) => const Divider(
                          height: 10,
                        ),
                    itemCount: value.pendingPayments.length),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorConstants.secondaryColor3,
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
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            value.totalPentingAmount.toString(),
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
      ),
    );
  }
}

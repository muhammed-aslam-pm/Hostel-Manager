import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/date_sorting_button.dart';
import 'package:hostel_management_app/view/owner_residents_page/widgets/residents_detailes_card.dart';

class OwnerResidentsPage extends StatelessWidget {
  const OwnerResidentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Residents Detailes",
          style: TextStyleConstants.homeMainTitle2,
        ),
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 0,
        leadingWidth: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [DateSortingButton(title: "All Residents")],
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ResidentsDetailescard(
                      roomNumber: 1,
                      bedNumber: 3,
                      joiningDate: "14 sep",
                      name: "Aslam",
                      isFeePaid: index % 2 == 0 ? true : false),
                  separatorBuilder: (context, index) => Divider(
                        color: ColorConstants.secondaryWhiteColor,
                        height: 10,
                      ),
                  itemCount: 5)
            ],
          ),
        ),
      ),
    );
  }
}

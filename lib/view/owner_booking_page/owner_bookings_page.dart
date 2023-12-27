import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/date_sorting_button.dart';
import 'package:hostel_management_app/view/booking_form/add_booking_screen.dart';
import 'package:hostel_management_app/view/owner_booking_page/widgets/bookings_card.dart';
import 'package:hostel_management_app/view/global_widgets/room_card.dart';

class OwnerBookingsPage extends StatelessWidget {
  const OwnerBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking Detailes",
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [DateSortingButton(title: "This Week")],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 45 / 100,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => BookingsCard(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Bookings",
                    style: TextStyleConstants.homeMainTitle2,
                  ),
                  Column(
                    children: [
                      Text(
                        'Total Beds vaccent',
                        style: TextStyleConstants.ownerRoomsText2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 15,
                        child: Text(
                          "10",
                          style: TextStyleConstants.ownerRoomsCircleAvtarText,
                        ),
                        backgroundColor: ColorConstants.primaryColor,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 10, left: 10),
                itemCount: 7,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 90,
                ),
                itemBuilder: (context, index) => RoomsCard(
                  roomNumber: index.toString(),
                  vaccentBedNumber: "3",
                  onTap: () {
                    showAdaptiveDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) => AddBookingScreen());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

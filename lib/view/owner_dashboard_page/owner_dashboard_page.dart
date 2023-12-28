import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/all_pending_payments_screen/pending_payments_screen.dart';
import 'package:hostel_management_app/view/announcement_adding_form/announcement_bottom_sheet.dart';
import 'package:hostel_management_app/view/owner_dashboard_page/widgets/date_card.dart';
import 'package:hostel_management_app/view/global_widgets/date_sorting_button.dart';
import 'package:hostel_management_app/view/owner_dashboard_page/widgets/going_to_vaccent_card.dart';
import 'package:hostel_management_app/view/owner_dashboard_page/widgets/maintenance_request_card.dart';
import 'package:hostel_management_app/view/owner_dashboard_page/widgets/pending_payment_card.dart';
import 'package:hostel_management_app/view/owner_dashboard_page/widgets/rooms_vaccent_card.dart';
import 'package:hostel_management_app/view/owner_dashboard_page/widgets/upcoming_bookings_card.dart';
import 'package:hostel_management_app/view/vacant_beds_screen/vacant_beds_screen.dart';

class OwnerDashBoardPage extends StatelessWidget {
  const OwnerDashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Welcom Back,",
              style: TextStyleConstants.homeMainTitle1,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Asha",
              style: TextStyleConstants.homeMainTitle2,
            )
          ],
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(ImageConstants.ownerHomeProfilePhoto),
          ),
          SizedBox(
            width: 30,
          ),
        ],
        titleSpacing: -20,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 11 / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoomVaccentCard(
                      title: "Beds Vacantnt",
                      number: "24",
                      bgColor: ColorConstants.SecondaryColor2,
                      image: ImageConstants.ownerRoomsIconeDisabled,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VacantBedsScreen(),
                            ));
                      },
                    ),
                    RoomVaccentCard(
                      title: "Paymenys penting",
                      number: "12",
                      bgColor: ColorConstants.SecondaryColor1,
                      image: ImageConstants.ownerRoomsIconeDisabled,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PendingPaymentsScreen(),
                            ));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Going to vaccent",
                  style: TextStyleConstants.dashboardSubtitle1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17, left: 20),
                child: Row(
                  children: [
                    DateSortingButton(title: "This month"),
                    SizedBox(
                      width: 18.6,
                    ),
                    DateCard(date: "12/12/2023")
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 80,
                  ),
                  itemBuilder: (context, index) => GoingToVaccentCard(
                      roomNumber: "13",
                      beadNumber: "2",
                      backgroungColor: ColorConstants.SecondaryColor4),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upcoming Bookings",
                      style: TextStyleConstants.dashboardSubtitle1,
                    ),
                    Text(
                      "Show all ",
                      style: TextStyleConstants.dashboardSubtitle2,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      4,
                      (index) => UpcomingBookings(
                          name: "Aslam",
                          date: "02/01/2024",
                          roomNumber: "26",
                          beadNumber: "5",
                          isAdvacePaid: true),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 33,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Hero(
                  tag: Title,
                  child: Text(
                    "Pending Payments",
                    style: TextStyleConstants.dashboardSubtitle1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Container(
                  height: 339,
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) => Container(
                      color: ColorConstants.secondaryWhiteColor,
                      height: 12,
                    ),
                    itemBuilder: (context, index) => PendingPaymentCard(
                        roomNumber: "26",
                        date: "12 sep",
                        amount: "800",
                        profilePhot1: ImageConstants.ownerHomeProfilePhoto2,
                        profilePhot2: ImageConstants.ownerHomeProfilePhoto3),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PendingPaymentsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.primaryColor,
                      ),
                      height: 40,
                      width: 150,
                      child: Center(
                        child: Text(
                          "Show All",
                          style: TextStyleConstants.buttonText,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Hero(
                  tag: "Maintenance request",
                  child: Text(
                    "Maintenance Request",
                    style: TextStyleConstants.dashboardSubtitle1,
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    10,
                    (index) => MaintenanceRequestCard(
                        roomNumber: "26",
                        complaint1: 'complaint1',
                        complaint2: 'complaint2',
                        day: '5'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AnnouncementAddingPage(),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            useSafeArea: true,
          );
        },
        child: Image.asset(
          ImageConstants.announcementIcon,
          color: ColorConstants.primaryBlackColor,
        ),
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 20,
      ),
    );
  }
}

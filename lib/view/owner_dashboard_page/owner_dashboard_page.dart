import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/bookings/bookings_controller.dart';
import 'package:hostel_management_app/controller/dashboard_controller/dashboard_controller.dart';
import 'package:hostel_management_app/controller/users/user_controller.dart';
import 'package:hostel_management_app/model/booking_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/all_pending_payments_screen/pending_payments_screen.dart';
import 'package:hostel_management_app/view/announcement_adding_form/announcement_bottom_sheet.dart';
import 'package:hostel_management_app/view/booked_resident_detailes_screen/booked_resident_detailes_screen.dart';
import 'package:hostel_management_app/view/owner_dashboard_page/widgets/date_card.dart';
import 'package:hostel_management_app/view/global_widgets/date_sorting_button.dart';
import 'package:hostel_management_app/view/owner_dashboard_page/widgets/going_to_vaccent_card.dart';
import 'package:hostel_management_app/view/owner_dashboard_page/widgets/maintenance_request_card.dart';
import 'package:hostel_management_app/view/owner_dashboard_page/widgets/pending_payment_card.dart';
import 'package:hostel_management_app/view/owner_dashboard_page/widgets/rooms_vaccent_card.dart';
import 'package:hostel_management_app/view/owner_dashboard_page/widgets/upcoming_bookings_card.dart';
import 'package:hostel_management_app/view/owner_profile_screen/owner_profile_screen.dart';
import 'package:hostel_management_app/view/vacant_beds_screen/vacant_beds_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OwnerDashBoardPage extends StatefulWidget {
  const OwnerDashBoardPage({super.key});

  @override
  State<OwnerDashBoardPage> createState() => _OwnerDashBoardPageState();
}

class _OwnerDashBoardPageState extends State<OwnerDashBoardPage> {
  final con = DashboardController();
  @override
  void initState() {
    Provider.of<UserController>(context, listen: false).fetchData();
    Provider.of<BookingsController>(context, listen: false).fetchBookingsData();
    Provider.of<DashboardController>(context, listen: false).fetchData();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UserController>(context);
    final bookingsController = Provider.of<BookingsController>(context);
    final dashboardController =
        Provider.of<DashboardController>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer(
              builder: (context, value, child) => Text(
                "Welcom Back,",
                style: TextStyleConstants.homeMainTitle1,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              controller.user!.ownwerName,
              style: TextStyleConstants.homeMainTitle2,
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OwnerProfileScreen(),
                  ));
            },
            child: Hero(
              tag: "profile",
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorConstants.primaryWhiteColor,
                  shape: BoxShape.circle,
                  image: controller.user!.profilePictuer.isNotEmpty
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(
                            controller.user!.profilePictuer,
                          ),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: AssetImage(ImageConstants.profileImage),
                          fit: BoxFit.fitWidth),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
        ],
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
                      number: controller.user?.noOfVacancy.toString() ?? "",
                      bgColor: ColorConstants.SecondaryColor2,
                      icon: Icon(
                        FluentIcons.bed_20_regular,
                        color: ColorConstants.primaryBlackColor,
                        size: 26,
                      ),
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
                      bgColor: ColorConstants.SecondaryColor3,
                      icon: Icon(
                        FluentIcons.conference_room_48_regular,
                        color: ColorConstants.primaryBlackColor,
                        size: 26,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PendingPaymentsScreen(),
                          ),
                        );
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
                    DateCard(date: dashboardController.date())
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
                  physics: ScrollPhysics(),
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
                        bookingsController.bookingsWithinThisWeek.length,
                        (index) {
                      BookingsModel booking =
                          bookingsController.bookingsWithinThisWeek[index];
                      return UpcomingBookings(
                        name: booking.name,
                        date: DateFormat('dd/MM/yyyy').format(booking.checkIn),
                        roomNumber: booking.roomNO.toString(),
                        beadNumber: "5",
                        isAdvacePaid: booking.advancePaid,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookedResidentDetailesScreen(
                                index: index,
                                isSorted: true,
                              ),
                            ),
                          );
                        },
                      );
                    }),
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
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AnnouncementAddingPage(),
            ),
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

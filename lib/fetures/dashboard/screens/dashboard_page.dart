import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/bookings/controllers/bookings_controller.dart';
import 'package:hostel_management_app/fetures/dashboard/controllers/dashboard_controller.dart';
import 'package:hostel_management_app/fetures/dashboard/widgets/vacant_rooms_loading.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_controller.dart';
import 'package:hostel_management_app/fetures/bookings/models/booking_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/fetures/payments/screens/pending_payments_screen.dart';
import 'package:hostel_management_app/fetures/bookings/screens/booked_resident_detailes_screen.dart';
import 'package:hostel_management_app/commens/widgets/custom_dropdown_button.dart';
import 'package:hostel_management_app/fetures/dashboard/widgets/date_card.dart';
import 'package:hostel_management_app/fetures/dashboard/widgets/going_to_vaccent_card.dart';
import 'package:hostel_management_app/fetures/dashboard/widgets/pending_payment_card.dart';
import 'package:hostel_management_app/fetures/dashboard/widgets/rooms_vaccent_card.dart';
import 'package:hostel_management_app/fetures/dashboard/widgets/upcoming_bookings_card.dart';
import 'package:hostel_management_app/fetures/profile/screens/profile_screen.dart';
import 'package:hostel_management_app/fetures/dashboard/screens/vacant_beds_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final con = DashboardController();
  @override
  void initState() {
    Provider.of<UserController>(context, listen: false).fetchData();
    Provider.of<BookingsController>(context, listen: false).fetchBookingsData();
    Provider.of<DashboardController>(context, listen: false).fetchData();
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
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width - 100,
              child: Text(
                controller.user!.ownwerName,
                overflow: TextOverflow.ellipsis,
                style: TextStyleConstants.homeMainTitle2,
              ),
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
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
          const SizedBox(
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
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 11 / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<UserController>(
                      builder: (context, value, child) => RoomVaccentCard(
                        title: "Beds Vacantnt",
                        number: value.user?.noOfVacancy.toString() ?? "",
                        bgColor: ColorConstants.primaryColor,
                        icon: Icon(
                          FluentIcons.bed_20_regular,
                          color: ColorConstants.primaryBlackColor,
                          size: 26,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VacantBedsScreen(),
                              ));
                        },
                      ),
                    ),
                    Consumer<DashboardController>(
                      builder: (context, value, child) => RoomVaccentCard(
                        title: "Paymenys penting",
                        number: value.rentPendingResidents.length.toString(),
                        bgColor: ColorConstants.secondaryColor3,
                        icon: Icon(
                          FluentIcons.conference_room_48_regular,
                          color: ColorConstants.primaryBlackColor,
                          size: 26,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PendingPaymentsScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
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
                    Consumer<DashboardController>(
                      builder: (context, value, child) => CustomDropdownButton(
                          selectedValue: value.selectedValue,
                          items: value.sortingItems,
                          onChanged: (p0) => value.selectFilter(p0),
                          height: 40,
                          width: 150),
                    ),
                    const SizedBox(
                      width: 18.6,
                    ),
                    DateCard(date: dashboardController.date())
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Consumer<DashboardController>(
                builder: (context, value, child) {
                  if (value.roomsGoingtoVacant.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: value.isFilterLoading
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: value.roomsGoingtoVacant.isEmpty
                                  ? 2
                                  : value.roomsGoingtoVacant.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 80,
                              ),
                              itemBuilder: (context, index) =>
                                  const VaccentLoadingCard())
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: value.roomsGoingtoVacant.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 80,
                              ),
                              itemBuilder: (context, index) =>
                                  GoingToVaccentCard(
                                      roomNumber: value
                                          .roomsGoingtoVacant[index]["RoomNo"]
                                          .toString(),
                                      beadNumber: value
                                          .roomsGoingtoVacant[index]["Vacancy"]
                                          .toString(),
                                      backgroungColor:
                                          ColorConstants.secondaryColor4),
                            ),
                    );
                  } else {
                    return SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                            "No Rooms going to Vacant this ${value.selectedValue}"),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
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
              const SizedBox(
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
              Consumer<DashboardController>(
                builder: (context, value, child) => Padding(
                  padding: const EdgeInsets.all(25),
                  child: SizedBox(
                    height: value.pendingPayments.length == 1
                        ? 100
                        : value.pendingPayments.length == 1
                            ? 200
                            : 339,
                    child: ListView.separated(
                        itemCount: value.pendingPayments.length,
                        physics: ScrollPhysics(),
                        separatorBuilder: (context, index) => Container(
                              color: ColorConstants.secondaryWhiteColor,
                              height: 12,
                            ),
                        itemBuilder: (context, index) {
                          Map<String, dynamic> pendingPayment =
                              value.pendingPayments[index];
                          return PendingPaymentCard(
                              roomNumber: pendingPayment["RoomNo"].toString(),
                              date: DateFormat('dd MMM').format(
                                  pendingPayment["Residents"][0].nextRentDate),
                              amount: pendingPayment["TotalAmount"].toString(),
                              profilePhot1:
                                  ImageConstants.ownerHomeProfilePhoto2,
                              profilePhot2:
                                  ImageConstants.ownerHomeProfilePhoto3);
                        }),
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
                          builder: (context) => const PendingPaymentsScreen(),
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
              // SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Hero(
              //     tag: "Maintenance request",
              //     child: Text(
              //       "Maintenance Request",
              //       style: TextStyleConstants.dashboardSubtitle1,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 13,
              // ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: List.generate(
              //       10,
              //       (index) => MaintenanceRequestCard(
              //           roomNumber: "26",
              //           complaint1: 'complaint1',
              //           complaint2: 'complaint2',
              //           day: '5'),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //   onPressed: () {
      //     showModalBottomSheet(
      //       isScrollControlled: true,
      //       context: context,
      //       builder: (context) => Padding(
      //         padding: EdgeInsets.only(
      //             bottom: MediaQuery.of(context).viewInsets.bottom),
      //         child: AnnouncementAddingPage(),
      //       ),
      //       elevation: 10,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(15),
      //       ),
      //       useSafeArea: true,
      //     );
      //   },
      //   child: Image.asset(
      //     ImageConstants.announcementIcon,
      //     color: ColorConstants.primaryBlackColor,
      //   ),
      //   backgroundColor: ColorConstants.primaryWhiteColor,
      //   elevation: 20,
      // ),
    );
  }
}

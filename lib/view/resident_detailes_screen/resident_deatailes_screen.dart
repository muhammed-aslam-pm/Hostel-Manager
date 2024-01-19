import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/residents/residents_controller.dart';
import 'package:hostel_management_app/model/resident_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/shimmer_loader.dart';
import 'package:hostel_management_app/view/resident_detailes_screen/widgets/confirm_delete_dialog.dart';
import 'package:hostel_management_app/view/resident_detailes_screen/widgets/resident_detailes_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ResidentDetailesScreen extends StatelessWidget {
  const ResidentDetailesScreen({super.key, required this.resident});

  final ResidentModel resident;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ResidentsController>(context, listen: false);
    return Consumer<ResidentsController>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorConstants.primaryWhiteColor,
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryWhiteColor,
          iconTheme: IconThemeData(color: ColorConstants.primaryBlackColor),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.chevron_left_outlined,
                size: 30,
              )),
          actions: [
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      child: const Text('Edit'),
                      onTap: () async {
                        controller.onEdit(resident, context);
                      }),
                  PopupMenuItem(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: ColorConstants.colorRed),
                    ),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context1) => ConfirmDeletDialog(
                          onPressed: () => controller.deleteResident(
                              context: context1, resident: resident),
                        ),
                      );
                      Navigator.pop(context);
                      // controller.deleteResident(
                      //     context: context, resident: value.residents[index]);
                    },
                  ),
                ];
              },
            ),
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "profile",
                      child: Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryWhiteColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: resident.profilePic.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: resident.profilePic,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  progressIndicatorBuilder:
                                      (context, url, progress) =>
                                          const ShimmerEffect(
                                              height: 110,
                                              width: 110,
                                              radius: 100),
                                )
                              : const Center(
                                  child: Icon(Icons.person),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorConstants.SecondaryColor4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 4),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageConstants.roomsIcon2,
                            color: ColorConstants.primaryBlackColor,
                            height: 25,
                            width: 25,
                          ),
                          Text(
                            resident.roomNo.toString(),
                            style: TextStyleConstants.bookingsRoomNumber,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: resident.isRentPaid
                              ? ColorConstants.colorGreen
                              : ColorConstants.colorRed),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      child: Center(
                          child: Text(
                        resident.isRentPaid ? "Fees Paid" : "Fees Not Paid",
                        style: TextStyleConstants.buttonText,
                      )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                DetailesCard(
                  tiltle: 'Name',
                  data: resident.name,
                ),
                const Text("Phone Number"),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorConstants.SecondaryColor2.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        resident.phone,
                        style: TextStyleConstants.dashboardBookingName,
                      ),
                      const InkWell(
                        child: Icon(
                          Icons.call,
                          size: 28,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DetailesCard(
                  tiltle: 'Email',
                  data: resident.email,
                ),
                DetailesCard(
                  tiltle: 'Address',
                  data: resident.address,
                ),
                DetailesCard(
                  tiltle: 'Purpose of Stay',
                  data: resident.purposOfStay,
                ),
                const Text("Eemergency Contact Number"),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorConstants.SecondaryColor2.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        resident.emargencyContact,
                        style: TextStyleConstants.dashboardBookingName,
                      ),
                      const InkWell(
                        child: Icon(
                          Icons.call,
                          size: 28,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DetailesCard(
                  tiltle: 'CheckOut Date',
                  data: DateFormat('dd/MM/yyyy').format(resident.checkIn),
                ),
                DetailesCard(
                  tiltle: 'CheckOut Date',
                  data: DateFormat('dd/MM/yyyy').format(resident.checkOut),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

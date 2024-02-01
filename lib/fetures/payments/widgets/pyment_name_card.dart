import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/commens/widgets/shimmer_loader.dart';
import 'package:hostel_management_app/fetures/residents/models/resident_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/fetures/residents/screens/resident_deatailes_screen.dart';

class PaymentNameCard extends StatelessWidget {
  const PaymentNameCard(
      {super.key,
      required this.name,
      required this.date,
      required this.rentAmount,
      required this.resident});
  final String name;
  final String date;
  final String rentAmount;
  final ResidentModel resident;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResidentDetailesScreen(
                residentId: resident.id!,
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstants.primaryWhiteColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Hero(
                    tag: name,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: ColorConstants.secondaryColor3,
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
                                            height: 30, width: 30, radius: 30),
                              )
                            : const Center(
                                child: Icon(Icons.person),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyleConstants.dashboardBookingName,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ImageConstants.calenderIcon,
                          ),
                          Text(
                            "$date due",
                            style: TextStyleConstants.dashboardPendingDue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      height: 18,
                      width: 9,
                      child: Image.asset(
                        ImageConstants.moneyIcon,
                        color: ColorConstants.primaryColor,
                      )),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(rentAmount,
                      style: TextStyleConstants.dashboardBookinRoomNo),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

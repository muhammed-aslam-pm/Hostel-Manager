import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/commens/functions/make_phone_call.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/commens/widgets/shimmer_loader.dart';

class ResidentsNameCard extends StatelessWidget {
  const ResidentsNameCard(
      {super.key,
      required this.name,
      this.onTap,
      required this.image,
      required this.phoneNo});
  final String name;
  final void Function()? onTap;
  final String image;
  final String phoneNo;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorConstants.primaryWhiteColor),
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Hero(
                  tag: name,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: ColorConstants.secondaryColor3,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: image.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      const ShimmerEffect(
                                          height: 60, width: 60, radius: 100),
                            )
                          : const Center(
                              child: Icon(Icons.person),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  name,
                  style: TextStyleConstants.dashboardBookingName,
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                makePhoneCall(phoneNo, context);
              },
              icon: Icon(
                Icons.call,
                color: ColorConstants.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

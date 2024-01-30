import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/commens/widgets/shimmer_loader.dart';

class ResidentsLoadingCard extends StatelessWidget {
  const ResidentsLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: ColorConstants.secondaryWhiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.primaryBlackColor.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(0, 4),
            )
          ]),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(height: 40, width: 40, radius: 20),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  ShimmerEffect(height: 20, width: 200, radius: 10),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 17,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      ShimmerEffect(height: 15, width: 100, radius: 5)
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ShimmerEffect(height: 30, width: 80, radius: 10)
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ShimmerEffect(height: 25, width: 60, radius: 10),
            ],
          )
        ],
      ),
    );
  }
}

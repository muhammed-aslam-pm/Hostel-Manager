import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/global_widgets/shimmer_loader.dart';

class ResidentsNameLoading extends StatelessWidget {
  const ResidentsNameLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: ColorConstants.primaryWhiteColor),
      padding: const EdgeInsets.only(right: 10),
      child: const Row(
        children: [
          ShimmerEffect(height: 60, width: 60, radius: 60),
          SizedBox(
            width: 15,
          ),
          ShimmerEffect(height: 30, width: 150, radius: 10)
        ],
      ),
    );
  }
}

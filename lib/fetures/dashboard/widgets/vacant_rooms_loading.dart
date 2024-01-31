import 'package:flutter/material.dart';
import 'package:hostel_management_app/commens/widgets/shimmer_loader.dart';

class VaccentLoadingCard extends StatelessWidget {
  const VaccentLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerEffect(height: 30, width: 30, radius: 15),
              ShimmerEffect(height: 25, width: 100, radius: 20)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerEffect(height: 30, width: 30, radius: 15),
              ShimmerEffect(height: 25, width: 100, radius: 20),
            ],
          ),
        ],
      ),
    );
  }
}

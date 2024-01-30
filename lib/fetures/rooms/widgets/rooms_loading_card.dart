import 'package:flutter/material.dart';
import 'package:hostel_management_app/commens/widgets/shimmer_loader.dart';

class RoomsLoadingCard extends StatelessWidget {
  const RoomsLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: ShimmerEffect(height: 80, width: 83, radius: 8),
        ),
        Positioned(
          top: 5,
          left: 30,
          child: ShimmerEffect(height: 30, width: 30, radius: 15),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_management_app/commens/widgets/shimmer_loader.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/fetures/payments/screens/pending_payments_screen.dart';

class PendingLoadingCard extends StatelessWidget {
  const PendingLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PendingPaymentsScreen(),
            ));
      },
      child: SizedBox(
        height: 106,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerEffect(height: 38, width: 38, radius: 38),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const ShimmerEffect(height: 35, width: 150, radius: 20),
                    Row(
                      children: [
                        Image.asset(
                          ImageConstants.calenderIcon,
                        ),
                        const ShimmerEffect(height: 25, width: 100, radius: 20),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.indianRupeeSign,
                      color: ColorConstants.primaryBlackColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const ShimmerEffect(height: 30, width: 100, radius: 20),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

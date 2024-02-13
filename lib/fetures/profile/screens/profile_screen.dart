import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_controller.dart';
import 'package:hostel_management_app/utils/animation_constants.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/commens/widgets/shimmer_loader.dart';
import 'package:hostel_management_app/fetures/profile/screens/profile_editing_screen.dart';
import 'package:hostel_management_app/fetures/profile/widgets/confirm_delete_dialog.dart';
import 'package:hostel_management_app/fetures/profile/widgets/confirm_logout_dialog.dart';
import 'package:hostel_management_app/fetures/profile/widgets/profile_detailes_card.dart';
import 'package:hostel_management_app/fetures/profile/widgets/room_no_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UserController>(context);
    const gap = SizedBox(
      height: 20,
    );
    return Scaffold(
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
          ),
        ),
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileEdingScreen(),
                          ));
                    }),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Text(
                        'Log Out',
                        style: TextStyle(color: ColorConstants.colorRed),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.logout,
                        size: 20,
                        color: ColorConstants.colorRed,
                      )
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ConfirmLogoutDialog(),
                    );
                  },
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Text(
                        'Delete Account',
                        style: TextStyle(color: ColorConstants.colorRed),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.delete,
                        size: 20,
                        color: ColorConstants.colorRed,
                      )
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ConfirmDeletDialog(),
                    );
                  },
                ),
              ];
            },
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "profile",
                child: Consumer<UserController>(
                  builder: (context, value, child) {
                    return Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryWhiteColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: value.isProfileUploading
                          ? Center(
                              child: LottieBuilder(
                                  lottie:
                                      AssetLottie(AnimationConstants.loading2)),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: controller.user!.profilePictuer.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: controller.user!.profilePictuer,
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
                                  : Image.asset(ImageConstants.profileImage),
                            ),
                    );
                  },
                ),
              ),
              TextButton(
                  onPressed: () {
                    Provider.of<UserController>(context, listen: false)
                        .uploadUserProfilePicture(context);
                  },
                  child: const Text("Change Profile Pic")),
              ProfileDetailesCard(
                title: "",
                data: controller.user!.hostelName,
              ),
              gap,
              ProfileDetailesCard(
                  title: "Owner Name", data: controller.user!.ownwerName),
              gap,
              ProfileDetailesCard(
                title: "Address",
                data: controller.user!.address,
              ),
              gap,
              ProfileDetailesCard(
                  title: "Phone Number", data: controller.user!.mobileNumber),
              gap,
              ProfileDetailesCard(
                  title: "Email", data: controller.user!.emailAddress),
              gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NumberCard(
                      title: "No of Rooms",
                      number: controller.user!.noOfRooms.toString()),
                  NumberCard(
                      title: "No of Beds",
                      number: controller.user!.noOfBeds.toString())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

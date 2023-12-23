import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/date_sorting_button.dart';

class OwnerRoomsPage extends StatelessWidget {
  const OwnerRoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rooms",
          style: TextStyleConstants.homeMainTitle2,
        ),
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateSortingButton(
                  title: "Floor 1",
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Total Beds',
                          style: TextStyleConstants.ownerRoomsText2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          radius: 15,
                          child: Text(
                            "56",
                            style: TextStyleConstants.ownerRoomsCircleAvtarText,
                          ),
                          backgroundColor:
                              ColorConstants.roomsCircleAvatarColor,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text(
                          'Total Beds vaccent',
                          style: TextStyleConstants.ownerRoomsText2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          radius: 15,
                          child: Text(
                            "10",
                            style: TextStyleConstants.ownerRoomsCircleAvtarText,
                          ),
                          backgroundColor: ColorConstants.primaryColor,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 85,
              ),
              itemBuilder: (context, index) => Container(
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: ColorConstants.secondaryWhiteColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstants.primaryBlackColor
                                      .withOpacity(0.2),
                                  blurRadius: 3,
                                  offset: Offset(0, 4),
                                )
                              ]),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Room No"), Text("$index")],
                            ),
                          ),
                        )),
                    Positioned(
                        top: 5,
                        left: 20,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: ColorConstants.SecondaryColor4,
                          child: Image.asset(
                            ImageConstants.ownerRoomsIconeDisabled,
                            color: ColorConstants.primaryBlackColor,
                          ),
                        )),
                    Positioned(
                      top: 0,
                      left: 55,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: ColorConstants.primaryColor,
                        child: Text(
                          "2",
                          style: TextStyleConstants.ownerRoomsCircleAvtarText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/date_sorting_button.dart';
import 'package:hostel_management_app/view/global_widgets/room_card.dart';
import 'package:hostel_management_app/view/owner_rooms_page/widgets/rooms_view_page.dart';

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
        leadingWidth: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
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
                              style:
                                  TextStyleConstants.ownerRoomsCircleAvtarText,
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
                              style:
                                  TextStyleConstants.ownerRoomsCircleAvtarText,
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
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 10, left: 10),
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 90,
                ),
                itemBuilder: (context, index) => RoomsCard(
                  roomNumber: index.toString(),
                  vaccentBedNumber: "3",
                  onTap: () {
                    showAdaptiveDialog(
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (context) => RoomsViewScreen(
                        roomNumber: index.toString(),
                        numberOfBeds: "6",
                        numberOfVaccentBeds: "2",
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

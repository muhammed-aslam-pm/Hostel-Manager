import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/date_sorting_button.dart';
import 'package:hostel_management_app/view/global_widgets/room_card.dart';
import 'package:hostel_management_app/view/room_detailes_screen/rooms_view_page.dart';
import 'package:hostel_management_app/view/rooms_adding_form/rooms_adding_form.dart';

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
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: RoomsAddingForm(),
            ),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            useSafeArea: true,
          );
        },
        child: Icon(
          Icons.add,
          color: ColorConstants.primaryColor,
          size: 30,
        ),
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 20,
      ),
    );
  }
}

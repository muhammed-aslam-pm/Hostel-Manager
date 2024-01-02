import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/room_card.dart';

class VacantBedsScreen extends StatelessWidget {
  const VacantBedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      appBar: AppBar(
        title: Text(
          "Vacant beds",
          style: TextStyleConstants.homeMainTitle2,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: ColorConstants.primaryColor,
            )),
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                        backgroundColor: ColorConstants.roomsCircleAvatarColor,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        ' Beds vaccent',
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
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 90,
                ),
                itemBuilder: (context, index) => RoomsCard(
                  roomNumber: index.toString(),
                  vaccentBedNumber: "3",
                  onTap: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

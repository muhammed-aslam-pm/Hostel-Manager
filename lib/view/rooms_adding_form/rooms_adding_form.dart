import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/rooms/rooms_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:provider/provider.dart';

class RoomsAddingForm extends StatelessWidget {
  const RoomsAddingForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RoomsController>(context, listen: false);
    final roomController = Provider.of<RoomsController>(context);
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: roomController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Room No",
                        style: TextStyleConstants.dashboardBookingName,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: roomController.roomNoController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: ColorConstants.primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 2, color: ColorConstants.primaryColor),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Capacity",
                        style: TextStyleConstants.dashboardBookingName,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: roomController.capacityController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: ColorConstants.primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 2, color: ColorConstants.primaryColor),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Rent",
              style: TextStyleConstants.dashboardBookingName,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: roomController.rentController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 1.5, color: ColorConstants.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 2, color: ColorConstants.primaryColor),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Facilities : ",
              style: TextStyleConstants.dashboardBookingName,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                FacilityCard(
                  facility: "AC",
                  onTap: () => controller.onSelect(0),
                  image: ImageConstants.ACIcon,
                  isSelected: roomController.ACselected,
                ),
                FacilityCard(
                    facility: "Washing Machine",
                    onTap: () => controller.onSelect(2),
                    isSelected: roomController.WMselected,
                    image: ImageConstants.washingMachineIcon),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                FacilityCard(
                    isSelected: roomController.ABselected,
                    facility: "Attached Bathroom",
                    onTap: () => controller.onSelect(3),
                    image: ImageConstants.bathroomIcon),
                FacilityCard(
                    isSelected: roomController.WFselected,
                    facility: "WiFi",
                    onTap: () => controller.onSelect(1),
                    image: ImageConstants.wifiIcon),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.primaryColor,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Center(
                      child: Text(
                        " Cancel",
                        style: TextStyleConstants.buttonText,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    if (roomController.formKey.currentState!.validate()) {
                      controller.addRoom();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.primaryColor,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Center(
                      child: Text(
                        "Add ",
                        style: TextStyleConstants.buttonText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class FacilityCard extends StatelessWidget {
  const FacilityCard({
    super.key,
    required this.facility,
    required this.image,
    this.onTap,
    required this.isSelected,
  });
  final String facility;
  final String image;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: ColorConstants.primaryWhiteColor,
              border: Border.all(
                  width: 2,
                  color: isSelected
                      ? ColorConstants.primaryBlackColor
                      : ColorConstants.SecondaryColor1)),
          padding: EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: ColorConstants.SecondaryColor5,
                child: SizedBox(
                    height: 22,
                    width: 22,
                    child: Image.asset(
                      image,
                      color: ColorConstants.primaryWhiteColor,
                    )),
              ),
              Text(
                "  $facility",
                style: TextStyleConstants.dashboardBookingName,
              )
            ],
          ),
        ),
      ),
    );
  }
}

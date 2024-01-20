import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/rooms/rooms_controller.dart';
import 'package:hostel_management_app/controller/users/user_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/rooms_adding_form/widgets/facilities_card.dart';
import 'package:provider/provider.dart';

class RoomsAddingForm extends StatelessWidget {
  const RoomsAddingForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RoomsController>(context, listen: false);
    final userController = Provider.of<UserController>(context, listen: false);
    final roomController = Provider.of<RoomsController>(context);
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.all(20),
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
                      const SizedBox(
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
                          validator: (value) =>
                              controller.fieldValidation(value),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Capacity",
                        style: TextStyleConstants.dashboardBookingName,
                      ),
                      const SizedBox(
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
                          validator: (value) =>
                              controller.fieldValidation(value),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Rent",
              style: TextStyleConstants.dashboardBookingName,
            ),
            const SizedBox(
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
                validator: (value) => controller.fieldValidation(value),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Facilities : ",
              style: TextStyleConstants.dashboardBookingName,
            ),
            const SizedBox(
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
            const SizedBox(
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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    controller.cancel(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.primaryColor,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Center(
                      child: Text(
                        " Cancel",
                        style: TextStyleConstants.buttonText,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                    if (roomController.formKey.currentState!.validate()) {
                      if (controller.isEditing) {
                        await controller.editRoom(context);
                        Navigator.pop(context);
                      } else {
                        await userController.fetchData();
                        final currentNoOfCapacity =
                            userController.user!.noOfBeds;
                        final currentNoOfVacany =
                            userController.user!.noOfVacancy;

                        controller.addRoom(
                            context: context,
                            currentCapacity: currentNoOfCapacity,
                            currentVacancy: currentNoOfVacany);
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.primaryColor,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Center(
                      child: Text(
                        roomController.isEditing ? "Edit" : "Add ",
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

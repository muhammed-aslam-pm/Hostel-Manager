import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/bookings/controllers/bookings_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'dart:ui' as ui;
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/fetures/bookings/widgets/booking_formfield.dart';
import 'package:provider/provider.dart';

class AddBookingScreen extends StatelessWidget {
  const AddBookingScreen(
      {super.key, required this.roomNo, required this.roomid});

  final int roomNo;

  final String roomid;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BookingsController>(context, listen: false);

    const gap = SizedBox(
      height: 10,
    );
    return BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: 5.0,
        sigmaY: 5.0,
      ),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: ColorConstants.secondaryColor5.withOpacity(0.5),
              borderRadius: BorderRadius.circular(40)),
          padding: const EdgeInsets.all(25),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.onCanacel();
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: ColorConstants.primaryWhiteColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: ColorConstants.primaryWhiteColor,
                              child: Hero(
                                tag: Image,
                                child: Image.asset(
                                  ImageConstants.roomsIcon2,
                                  color: ColorConstants.primaryBlackColor,
                                ),
                              ),
                            ),
                            Text(
                              "Room No",
                              style: TextStyleConstants.ownerRoomNumber2,
                            ),
                            Text(
                              roomNo.toString(),
                              style: TextStyleConstants.ownerRoomNumber3,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text("Name "),
                    gap,
                    BookingTextField(
                      controller: controller.nameController,
                      validator: (p0) => controller.fieldValidation(p0),
                    ),
                    gap,
                    const Text("Phone no"),
                    gap,
                    BookingTextField(
                      controller: controller.phoneNoController,
                      validator: (p0) => controller.fieldValidation(p0),
                    ),
                    gap,
                    const Text("Joining date"),
                    gap,
                    InkWell(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                        );
                        controller.setDate(date!);
                      },
                      child: BookingTextField(
                        controller: controller.dateController,
                        validator: (p0) => controller.fieldValidation(p0),
                        suffix: Icon(
                          Icons.calendar_month_outlined,
                          color: ColorConstants.primaryWhiteColor,
                        ),
                        enablde: false,
                      ),
                    ),
                    gap,
                    const Text("Advance"),
                    gap,
                    Consumer<BookingsController>(
                      builder: (context, value, child) => Row(
                        children: [
                          RadioMenuButton(
                            value: true,
                            groupValue: controller.isAdvancePaid,
                            onChanged: (value) => controller.advance(value!),
                            child: const Text("Paid"),
                          ),
                          RadioMenuButton(
                              style: const ButtonStyle(),
                              value: false,
                              groupValue: controller.isAdvancePaid,
                              onChanged: (value) => controller.advance(value!),
                              child: const Text("Not Paid"))
                        ],
                      ),
                    ),
                    gap,
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            if (controller.isEditing) {
                              controller.updateBooking(context);
                            } else {
                              controller.addBooking(
                                  context: context,
                                  roomNo: roomNo,
                                  roomId: roomid);
                            }
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              controller.isEditing ? "Edit" : "Add",
                              style: TextStyleConstants.buttonText,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}

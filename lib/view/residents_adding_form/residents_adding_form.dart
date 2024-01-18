import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/residents/residents_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/custom_dropdown_button.dart';
import 'package:provider/provider.dart';

class ResidentsAddingPage extends StatefulWidget {
  const ResidentsAddingPage({super.key});

  @override
  State<ResidentsAddingPage> createState() => _ResidentsAddingPageState();
}

class _ResidentsAddingPageState extends State<ResidentsAddingPage> {
  @override
  void initState() {
    Provider.of<ResidentsController>(context, listen: false).fetchVacantRooms();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ResidentsController>(context, listen: false);
    const gap = SizedBox(
      height: 10,
    );
    return Container(
      padding: EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      Positioned(
                          child: Hero(
                        tag: Form,
                        child: InkWell(
                          onDoubleTap: () => controller.openImagePicker(),
                          child: Consumer<ResidentsController>(
                            builder: (context, value, child) => CircleAvatar(
                              radius: 50,
                              backgroundColor: ColorConstants.SecondaryColor4,
                              backgroundImage: controller.selectedImage != null
                                  ? FileImage(
                                      File(controller.selectedImage!.path)
                                          as File)
                                  : null,
                              child: controller.selectedImage == null
                                  ? Icon(
                                      Icons.person,
                                      color: ColorConstants.primaryBlackColor,
                                      size: 40,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      )),
                      Positioned(
                        bottom: 3,
                        right: 3,
                        child: CircleAvatar(
                          radius: 13,
                          backgroundColor: ColorConstants.SecondaryColor5,
                          child: Icon(Icons.add),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              gap,
              gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Room no :"),
                  Consumer<ResidentsController>(
                    builder: (context, value, child) => CustomDropdownButton1(
                        selectedValue: controller.selectedRoom!,
                        items: controller.vacantRoomNoList,
                        onChanged: (p0) => controller.selectRoom(p0),
                        height: 50,
                        width: 100),
                  ),
                ],
              ),
              gap,
              const Text("Name"),
              gap,
              CustomFormField(
                controller: controller.nameController,
                validator: (p0) => controller.fieldValidation(p0),
              ),
              gap,
              const Text("Phone no"),
              gap,
              CustomFormField(
                controller: controller.phoneNoController,
                validator: (p0) => controller.fieldValidation(p0),
              ),
              gap,
              const Text(
                "Emaile",
              ),
              gap,
              CustomFormField(
                controller: controller.emailController,
                validator: (p0) => controller.fieldValidation(p0),
              ),
              gap,
              const Text("Address"),
              gap,
              CustomFormField(
                controller: controller.addressController,
                isExpanded: true,
                validator: (p0) => controller.fieldValidation(p0),
              ),
              gap,
              const Text(
                "Emergency Contact no",
              ),
              gap,
              CustomFormField(
                controller: controller.emargencyContactController,
                validator: (p0) => controller.fieldValidation(p0),
              ),
              gap,
              const Text("Purpose of Stay"),
              gap,
              CustomFormField(controller: controller.purposeController),
              gap,
              const Text(
                "Joining date",
              ),
              gap,
              CustomFormField(
                controller: controller.checkInDateController,
                validator: (p0) => controller.fieldValidation(p0),
                suffixWidget: InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2025));
                    controller.setCheckInDate(date!);
                  },
                  child: Icon(
                    Icons.calendar_month_outlined,
                    color: ColorConstants.roomsBlackColor,
                  ),
                ),
              ),
              gap,
              const Text("Ending Date (optional)"),
              gap,
              CustomFormField(
                  controller: controller.checkOutDateController,
                  validator: (p0) => controller.fieldValidation(p0),
                  suffixWidget: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: controller.checkInDate ?? DateTime(2024),
                          firstDate: controller.checkInDate ?? DateTime(2024),
                          lastDate: DateTime(2025));
                      controller.setCheckOutDate(date!);
                    },
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: ColorConstants.roomsBlackColor,
                    ),
                  )),
              gap,
              Center(
                child: InkWell(
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.addResident(context);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.primaryColor),
                    child: Center(
                      child: Text(
                        "Add",
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
    );
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.controller,
    this.suffixWidget,
    this.isExpanded = false,
    this.validator,
  });
  final TextEditingController controller;
  final Widget? suffixWidget;
  final bool isExpanded;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isExpanded ? 100 : 50,
      child: TextFormField(
        expands: isExpanded,
        validator: validator ?? null,
        maxLines: isExpanded ? null : 1,
        controller: controller,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(width: 1.5, color: ColorConstants.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(width: 2, color: ColorConstants.primaryColor),
            ),
            suffixIcon: suffixWidget ?? null),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/residents/controllers/residents_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/commens/widgets/custom_dropdown_button.dart';
import 'package:hostel_management_app/fetures/residents/widgets/custom_formfield.dart';
import 'package:provider/provider.dart';

class ResidentsAddingPage extends StatelessWidget {
  const ResidentsAddingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ResidentsController>(context, listen: false);
    const gap = SizedBox(
      height: 10,
    );
    return Container(
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: InkWell(
                    onTap: () => controller.openImagePicker(),
                    child: Stack(
                      children: [
                        Positioned(
                            child: Hero(
                          tag: Form,
                          child: Consumer<ResidentsController>(
                            builder: (context, value, child) => CircleAvatar(
                              radius: 50,
                              backgroundColor: ColorConstants.secondaryColor4,
                              backgroundImage: controller.selectedImage != null
                                  ? FileImage(
                                      File(controller.selectedImage!.path))
                                  : controller.oldImage != ""
                                      ? NetworkImage(controller.oldImage)
                                          as ImageProvider<Object>?
                                      : null,
                              child: controller.selectedImage == null &&
                                      controller.oldImage == ""
                                  ? Icon(
                                      Icons.person,
                                      color: ColorConstants.primaryBlackColor,
                                      size: 40,
                                    )
                                  : null,
                            ),
                          ),
                        )),
                        Positioned(
                          bottom: 3,
                          right: 3,
                          child: CircleAvatar(
                            radius: 13,
                            backgroundColor: ColorConstants.secondaryColor5,
                            child: const Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
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
                    builder: (context, value, child) => CustomDropdownButton(
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
                      if (controller.isEditing) {
                        controller.editResident(context);
                      } else {
                        controller.addResident(context);
                      }
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
    );
  }
}

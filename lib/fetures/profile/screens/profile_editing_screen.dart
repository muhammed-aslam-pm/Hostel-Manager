import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/commens/widgets/form_field.dart';
import 'package:provider/provider.dart';

class ProfileEdingScreen extends StatefulWidget {
  const ProfileEdingScreen({super.key});

  @override
  State<ProfileEdingScreen> createState() => _ProfileEdingScreenState();
}

class _ProfileEdingScreenState extends State<ProfileEdingScreen> {
  @override
  void initState() {
    Provider.of<UserController>(context, listen: false).fillForm();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(
      height: 20,
    );
    final controller = Provider.of<UserController>(context);
    return Scaffold(
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
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Form(
                key: controller.profileUpdateFormKey,
                child: Column(
                  children: [
                    CustomFormField(
                      controller: controller.nameController,
                      labelText: 'Name',
                      validator: (p0) {
                        controller.fieldValidation(p0!);
                        return null;
                      },
                    ),
                    gap,
                    CustomFormField(
                      controller: controller.hostelNameController,
                      labelText: 'Hostel Name',
                      validator: (p0) {
                        controller.fieldValidation(p0!);
                        return null;
                      },
                    ),
                    gap,
                    CustomFormField(
                      controller: controller.emailController,
                      labelText: 'Email',
                      validator: (p0) {
                        controller.fieldValidation(p0!);
                        return null;
                      },
                    ),
                    gap,
                    CustomFormField(
                      controller: controller.phoneNoController,
                      labelText: 'Phone No',
                      validator: (p0) {
                        controller.fieldValidation(p0!);
                        return null;
                      },
                    ),
                    gap,
                    SizedBox(
                      height: 100,
                      child: TextFormField(
                        maxLines: 10,
                        textAlignVertical: TextAlignVertical.top,
                        textAlign: TextAlign.start,
                        controller: controller.addressController,
                        validator: (value) => controller.fieldValidation(value),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 2, color: ColorConstants.colorGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 2, color: ColorConstants.primaryColor),
                          ),
                          label: const Text("Address"),
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: ColorConstants.colorGrey,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    gap,
                    CustomFormField(
                      controller: controller.roonNoController,
                      labelText: 'No of Rooms',
                      validator: (p0) {
                        controller.fieldValidation(p0!);
                        return null;
                      },
                    ),
                    gap,
                    gap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.secondaryColor2,
                            ),
                            height: 50,
                            width: 150,
                            child: Center(
                              child: Text(
                                "cancel",
                                style: TextStyleConstants.buttonText,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.profileUpdateFormKey.currentState!
                                .validate()) {
                              Provider.of<UserController>(context,
                                      listen: false)
                                  .updateData(context);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.primaryColor,
                            ),
                            height: 50,
                            width: 150,
                            child: Center(
                              child: Text(
                                "Update",
                                style: TextStyleConstants.buttonText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

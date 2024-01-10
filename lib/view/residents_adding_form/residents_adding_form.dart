import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';

class ResidentsAddingPage extends StatelessWidget {
  const ResidentsAddingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: SingleChildScrollView(
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
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: ColorConstants.SecondaryColor4,
                        child: Icon(
                          Icons.person,
                          color: ColorConstants.primaryBlackColor,
                          size: 40,
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
            SizedBox(
              height: 20,
            ),
            Text("Room no"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 1, color: ColorConstants.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 2, color: ColorConstants.primaryColor),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Bed no"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 1, color: ColorConstants.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 2, color: ColorConstants.primaryColor),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Name"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
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
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Phone no"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
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
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Emaile"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Address"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: TextFormField(
                maxLines: null,
                expands: true,
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Emergency Contact no"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
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
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Purpose of Stay"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
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
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Joining date"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
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
                  suffixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: ColorConstants.roomsBlackColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Ending Date (optional)"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
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
                  suffixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: ColorConstants.roomsBlackColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
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
            )
          ],
        ),
      ),
    );
  }
}

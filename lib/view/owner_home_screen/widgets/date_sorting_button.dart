import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';

class DateSortingButton extends StatelessWidget {
  const DateSortingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 4.5 / 100,
      width: MediaQuery.sizeOf(context).width * 30 / 100,
      padding: EdgeInsets.symmetric(horizontal: 12.5, vertical: 10),
      decoration: BoxDecoration(
          color: ColorConstants.SecondaryColor3,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("This month"),
          DropdownButton(
            items: [],
            onChanged: (value) {},
            dropdownColor: ColorConstants.primaryBlackColor,
            iconDisabledColor: ColorConstants.primaryBlackColor,
          )
        ],
      ),
    );
  }
}
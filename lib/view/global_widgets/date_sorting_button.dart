import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';

class DateSortingButton extends StatelessWidget {
  const DateSortingButton({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.5, vertical: 10),
      decoration: BoxDecoration(
          color: ColorConstants.SecondaryColor3,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
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

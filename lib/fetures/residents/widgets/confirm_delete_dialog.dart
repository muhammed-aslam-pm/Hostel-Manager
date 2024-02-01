import 'package:flutter/material.dart';
import 'package:hostel_management_app/utils/color_constants.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    this.onPressed,
    required this.title,
    required this.content,
    this.button2Text = "Delete",
    this.button1Text = "Cancel",
  });
  final void Function()? onPressed;
  final String title;
  final String content;
  final String? button2Text;
  final String? button1Text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Text(content),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(button1Text!),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(ColorConstants.colorRed)),
          onPressed: onPressed,
          child: Text(button2Text!),
        ),
      ],
    );
  }
}

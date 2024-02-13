import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/profile/controllers/user_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:provider/provider.dart';

class ConfirmDeletDialog extends StatelessWidget {
  const ConfirmDeletDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Text(
        'Confirm Delete',
        textAlign: TextAlign.center,
      ),
      content: const Text(
          'Are you sure you want to Delete your Account permenetly?'),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(context)
                .pop(false); 
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(ColorConstants.colorRed)),
          onPressed: () async {
            Provider.of<UserController>(context, listen: false)
                .deleteUserAccount(context);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

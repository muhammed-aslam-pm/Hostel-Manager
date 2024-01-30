import 'package:flutter/material.dart';
import 'package:hostel_management_app/fetures/bookings/controllers/bookings_controller.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:provider/provider.dart';

class DeletDialog extends StatelessWidget {
  const DeletDialog({
    super.key,
    required this.bookingId,
    required this.roomId,
  });
  final String bookingId, roomId;

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
          'Are you sure you want to Delelte this record permenetly?'),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(context)
                .pop(false); // Dismiss the dialog and return false
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(ColorConstants.colorRed)),
          onPressed: () async {
            Provider.of<BookingsController>(context, listen: false)
                .deleteBooking(
                    context: context, bookingId: bookingId, roomId: roomId);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

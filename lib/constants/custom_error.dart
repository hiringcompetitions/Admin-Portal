import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';

class CustomError {
  final state;
  CustomError(
    this.state,
  );

  void showToast(BuildContext context, String desc) {
    if (state == "error") {
      ElegantNotification.error(
          width: 300,
          title: Text("Oops!"),
          description: SizedBox(
            height: 50, 
            child: SingleChildScrollView(
              child: SelectableText(desc),
            ),
          )).show(context);
    } else if (state == "success") {
      ElegantNotification.success(
        width: 300,
        title: Text('Success'),
        description: Text(desc),
      ).show(context);
    }
  }
}

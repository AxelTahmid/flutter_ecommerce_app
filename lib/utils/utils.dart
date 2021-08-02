import 'package:flutter/material.dart';

class Utils {
  static void showMessage(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPressed, {
    bool isConfirmationDialog = false,
    String buttonText2 = "",
    Function onPressed2,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                return onPressed();
              },
              child: Text(buttonText),
            ),
            Visibility(
              visible: isConfirmationDialog,
              child: TextButton(
                onPressed: () {
                  return onPressed2();
                },
                child: Text(buttonText2),
              ),
            )
          ],
        );
      },
    );
  }
}

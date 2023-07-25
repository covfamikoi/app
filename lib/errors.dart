import 'package:flutter/material.dart';

dynamic processError(BuildContext context, dynamic error, {bool allowPop = false}) {
  if (error == 401) {
    // unauthorized
    // todo: unset jwt token
    return error;
  } else if (error == 403) {
    // forbidden
    return error;
  }

  if (allowPop) Navigator.pop(context);
  showErrorAlert(context, "Error: $error");
  throw error;
}

void showErrorAlert(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      showCloseIcon: true,
      backgroundColor: Colors.red.shade300,
      duration: const Duration(seconds: 30)));
}
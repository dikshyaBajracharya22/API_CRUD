import 'package:flutter/material.dart';

class SnackbarUtils {
  static showSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      maxLines: 1,
    )));
  }
}

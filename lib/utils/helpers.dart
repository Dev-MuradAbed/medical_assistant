import 'package:flutter/material.dart';

mixin Helper {
  void showSnackBar(BuildContext context,
      {required String message, required bool error}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: error ? Colors.red : Colors.green,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ));
  }
}

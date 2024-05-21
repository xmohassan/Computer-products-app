import 'package:computer_products_app/shared/colors.dart';
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: bTNBlue,
    duration: const Duration(days: 1),
    content: Text(
      text,
      style: const TextStyle(color: Colors.red),
    ),
    action: SnackBarAction(
        label: "close", textColor: Colors.white, onPressed: () {}),
  ));
}

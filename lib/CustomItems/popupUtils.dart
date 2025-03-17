import 'package:flutter/material.dart';

import 'customPopup.dart';


void showCustomPopup(BuildContext context, String title, String message,
    String cancelButtonName, String confirmButtonName, VoidCallback onConfirm,
    Color confirmColor, double cancelLeftRightPadding) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomPopup(
        title: title,
        message: message,
        cancelButtonName: cancelButtonName,
        confirmButtonName: confirmButtonName,
        confirmColor: confirmColor,
        cancelLeftRightPadding: cancelLeftRightPadding,
        onConfirm: onConfirm,

      );
    },
  );
}
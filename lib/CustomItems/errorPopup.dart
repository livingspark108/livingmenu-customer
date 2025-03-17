import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:living_menu_mobile/Constants/appFontSizes.dart';

class ErrorPopup {

  static Future<void> showGlobalPopup({
    required BuildContext context,
    required String title,
    required Color titleColor,
    required String message,
    required String buttonText,
    required Color buttonTextColor,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismiss on outside tap
      builder: (BuildContext context) {
        AppFontSizes fontSizes = AppFontSizes(context);
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            title,
            style: TextStyle(
              fontSize: fontSizes.fontSize16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins_semi_bold',
              color: titleColor
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
                fontSize: fontSizes.fontSize14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins_regular'
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: fontSizes.fontSize16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins_semi_bold',
                  color: buttonTextColor, // Customize the button color
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

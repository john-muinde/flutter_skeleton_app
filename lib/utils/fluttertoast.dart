// implement fluttertoast but using snackbar

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:study_buddy_app/constants/colors.dart';

class CustomizedFluttertoast {
  static void showToast(String msg, Color backgroundColor, Color textColor) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  static void showSuccessToast(String msg) {
    showToast(msg, ColorPalette.successColor, ColorPalette.onSuccessColor);
  }

  static void showErrorToast(String msg) {
    showToast(msg, ColorPalette.errorColor, ColorPalette.onErrorColor);
  }
}

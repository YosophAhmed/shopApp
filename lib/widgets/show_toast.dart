import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStates {
  success,
  warning,
  error,
}

void showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: toastColor(state: state),
    textColor: Colors.white,
    fontSize: 16,
  );
}

Color toastColor({
  required ToastStates state,
}) {
  switch (state) {
    case ToastStates.success:
      return Colors.greenAccent;
    case ToastStates.warning:
      return Colors.yellowAccent;
    case ToastStates.error:
      return Colors.redAccent;
  }
}

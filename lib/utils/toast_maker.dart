import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMaker {
  static void showToast({required content, length = Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
      msg: content,
      toastLength: length,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[700],
      textColor: Colors.white,
    );
  }
}

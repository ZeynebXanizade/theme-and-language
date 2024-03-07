import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToast {
  static showToasts(
      {required BuildContext context, required String msg}) async {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Theme.of(context).colorScheme.onPrimary ,
      textColor: Theme.of(context).colorScheme.primary,
      fontSize: 20,
      msg: msg,
    );
  }
}

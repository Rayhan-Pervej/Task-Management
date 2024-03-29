import 'package:flutter/material.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';

void showSnackBar({
  required BuildContext context,
  String? title,
  required String message,
  required bool error,
  double? height,
  Duration? duration,
}) {
  final size = MediaQuery.of(context).size;

  var snackBar = SnackBar(
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title != null)
          Text(
            title,
            style: TextDesign().snackBar,
          ),
        Text(
          message,
          style: TextDesign().snackBar,
        )
      ],
    ),
    backgroundColor: error ? MyColor.alertRed : MyColor.alertBlue,
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
    margin: EdgeInsets.only(
        bottom: size.height - (height ?? 80), left: 50, right: 50),
    elevation: 6,
    duration: duration ?? const Duration(seconds: 3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    clipBehavior: Clip.hardEdge,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

import 'package:flutter/material.dart';
import 'package:user/constant.dart';

PreferredSizeWidget appbar(
  BuildContext context, {
  String title = '',
  Function()? onPressed,
  IconData? actionIcon,
}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: 'Times New Roman',
      ),
    ),
    elevation: 0,
    backgroundColor: primarycolor,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios,
      ),
    ),
    actions: [
      IconButton(
        onPressed: onPressed,
        color: Colors.white,
        icon: Icon(actionIcon),
      ),
    ],
  );
}

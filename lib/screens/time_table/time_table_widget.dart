import 'package:flutter/material.dart';
import 'package:user/constant.dart';

class TimeTableColumn extends StatelessWidget {
  const TimeTableColumn({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        kHalfSizedBox,
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}

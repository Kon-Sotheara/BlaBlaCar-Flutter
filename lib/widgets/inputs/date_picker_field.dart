import 'package:blabla/theme/theme.dart';
import 'package:blabla/utils/date_time_util.dart';
import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({super.key, required this.date});

  final DateTime date;

  String get dateFormat => DateTimeUtils.formatDateTime(date);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
      leading: Icon(
        Icons.calendar_month_outlined,
        size: 23,
        color: BlaColors.neutralLight,
      ),
      title: Text(dateFormat, style: TextStyle(color: BlaColors.neutral),),
    );
  }
}

import 'package:blabla/theme/theme.dart';
import 'package:flutter/material.dart';

class PassagerCount extends StatelessWidget {
  const PassagerCount({super.key, required this.requestedSeat});

  final int requestedSeat;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
      leading: Icon(Icons.person_outline, color: BlaColors.neutralLight),
      title: Text(
        requestedSeat.toString(),
        style: TextStyle(color: BlaColors.neutral),
      ),
    );
  }

}

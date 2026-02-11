import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/theme/theme.dart';
import 'package:flutter/material.dart';

class LocationPickerField extends StatelessWidget {
  const LocationPickerField({
    super.key,
    required this.label,
    this.seletedLocation,
    required this.onTap
  });

  final String label;
  final Location? seletedLocation;
  final VoidCallback onTap;

  Color get labelColor =>
      seletedLocation == null ? BlaColors.neutralLight : BlaColors.neutral;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
      leading: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 4, color: BlaColors.neutralLight),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      title: Text(
        seletedLocation?.name ?? label,
        style: TextStyle(color: labelColor)
      ),
    );
  }
}

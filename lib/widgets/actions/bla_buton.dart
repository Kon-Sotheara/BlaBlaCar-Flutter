import 'package:blabla/theme/theme.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  const BlaButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    required this.buttonType,
    this.isFlat = false
  });

  final String label;
  final IconData? icon;
  final ButtonType buttonType;
  final VoidCallback? onTap;
  final bool isFlat;

  Color get backgroundButton =>
      buttonType == ButtonType.primary ? BlaColors.primary : Colors.white;

  Color get labelColor =>
      buttonType == ButtonType.primary ? Colors.white : BlaColors.primary;

  Color get boderColor =>
      buttonType == ButtonType.primary ? BlaColors.primary : Colors.grey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundButton,
          foregroundColor: labelColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: isFlat
                ? BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
                : BorderRadius.circular(24),
            side: BorderSide(color: boderColor),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon), const SizedBox(width: 10)],
            Text(
              label,
              style: BlaTextStyles.button,
            ),
          ],
        ),
      ),
    );
  }
}

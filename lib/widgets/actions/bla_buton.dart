import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  const BlaButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    required this.buttonType,
  });

  final String label;
  final IconData? icon;
  final ButtonType buttonType;
  final VoidCallback? onTap;

  Color get backgroundButton =>
      buttonType == ButtonType.primary ? Colors.blue : Colors.white;

  Color get labelColor =>
      buttonType == ButtonType.primary ? Colors.white : Colors.blue;

  Color get boderColor =>
      buttonType == ButtonType.primary ? Colors.blue : Colors.grey;

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
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: boderColor),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon),
              const SizedBox(width: 10)
            ],
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

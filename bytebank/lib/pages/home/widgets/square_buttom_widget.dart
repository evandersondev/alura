import 'package:flutter/material.dart';

class SquareButtomWidget extends StatelessWidget {
  const SquareButtomWidget({
    Key? key,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 60,
          width: 60,
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}

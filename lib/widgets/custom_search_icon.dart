import 'package:flutter/material.dart';
import 'package:shop_app/constants/colors.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final Function() onTap;

  const CustomIcon({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Icon(
            icon,
            size: 36,
            color: defaultColor,
          ),
        ),
      ),
    );
  }
}
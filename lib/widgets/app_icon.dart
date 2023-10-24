import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:hardware_app/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const AppIcon({Key? key,
  required this.icon,
this.backgroundColor = const Color(0XffFcf4e4),
    this.iconColor = const Color(0xff756d54),
    this.size=40
  }) :super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor,
      ),
        child: Icon(
      icon,
      color: iconColor,
      size: Dimensions.iconSize16,
      ),

    );
  }
}

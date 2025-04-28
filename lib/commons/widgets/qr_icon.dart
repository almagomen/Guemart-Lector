import 'package:flutter/material.dart';

class QRIcon extends StatelessWidget {
  final double iconSize;
  final IconData iconData;
  final Color iconColor;
  final double iconOpacity = 1.0;
  final double iconScale = 1.0;

  
  const QRIcon({
    super.key,
    this.iconColor = Colors.black,
    required this.iconSize,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {    
    return Icon(iconData, size: iconSize, color: iconColor);
  }
}
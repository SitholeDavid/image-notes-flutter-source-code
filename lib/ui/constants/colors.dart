import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

final Color primaryColor = HexColor('#5e35b1');
final Color primaryColorLight = HexColor('#9162e4');
final Color primaryColorDark = HexColor('#280680');
final Color backgroundColor = HexColor('#fafafa');
final Color textColor = Colors.black87;

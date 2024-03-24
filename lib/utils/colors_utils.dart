import 'package:flutter/material.dart';

class ColorUtils {
  Color primarycolor = HexColor("2196f3");
  Color greycolor = HexColor("929794");
  Color searchgreycolor = HexColor("e6e6e6");
  Color darkcolor = HexColor("3D56F0");
  Color bluecolor = HexColor("5468FF");
  Color violetcolor = HexColor("5120AE");
  Color lightVioletColor = HexColor("7085C3");
  Color redColor = HexColor("f44336");
  Color green=HexColor("99D35C");
  Color lightgreyColor =HexColor("9097A0");
  Color lightygreytextcolor =HexColor("D0D7DC");
  Color lightbgcolor =HexColor("EFEFEF");
  Color greycolortxt=HexColor("46455A");
  Color blue = HexColor('#00A1E0');
 static final Color lightBlue = HexColor('#1D8DCF');
  Color addresslabletext=HexColor("707070");
  Color lightgreybtn=HexColor("EBEAEA");
  Color lightbluecolor=HexColor("00AEF3");
}

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

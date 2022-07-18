import 'dart:ui';

class ColorsStyle{
 static final Color azulRoxo = getColorByHex("#4D3CC3");

  static Color getColorByHex(String hex) {
    return Color(int.parse("0xFF${hex.replaceAll('#', '')}"));
  } 
}
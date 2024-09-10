import 'package:flutter/material.dart' show Color, MaterialColor;

abstract class AppColors {
  // Jade
  static const Color jade50 = Color(0xFFeafff3);
  static const Color jade100 = Color(0xFFcdfee1);
  static const Color jade200 = Color(0xFFa0faca);
  static const Color jade300 = Color(0xFF63f2ae);
  static const Color jade400 = Color(0xFF25e28e);
  static const Color jade500 = Color(0xFF00b96d);
  static const Color jade600 = Color(0xFF00a461);
  static const Color jade700 = Color(0xFF008352);
  static const Color jade800 = Color(0xFF006742);
  static const Color jade900 = Color(0xFF005537);
  static const Color jade950 = Color(0xFF003020);
  // silver
  static const Color silver50 = Color(0xFFf7f7f7);
  static const Color silver100 = Color(0xFFf0f0f0);
  static const Color silver200 = Color(0xFFe3e3e3);
  static const Color silver300 = Color(0xFFd1d1d1);
  static const Color silver400 = Color(0xFFc1c1c1);
  static const Color silver500 = Color(0xFFaaaaaa);
  static const Color silver600 = Color(0xFF969696);
  static const Color silver700 = Color(0xFF818181);
  static const Color silver800 = Color(0xFF6a6a6a);
  static const Color silver900 = Color(0xFF585858);
  static const Color silver950 = Color(0xFF333333);
  // visvis
  static const Color visVis50 = Color(0xFFfffbeb);
  static const Color visVis100 = Color(0xFFfff3c6);
  static const Color visVis200 = Color(0xFFffeca6);
  static const Color visVis300 = Color(0xFFffd34a);
  static const Color visVis400 = Color(0xFFffbe20);
  static const Color visVis500 = Color(0xFFf99c07);
  static const Color visVis600 = Color(0xFFdd7402);
  static const Color visVis700 = Color(0xFFb75106);
  static const Color visVis800 = Color(0xFF943d0c);
  static const Color visVis900 = Color(0xFF7a330d);
  static const Color visVis950 = Color(0xFF461902);
  // Radical red
  static const Color radicalRed50 = Color(0xFFfff1f2);
  static const Color radicalRed100 = Color(0xFFffe4e6);
  static const Color radicalRed200 = Color(0xFFfecdd3);
  static const Color radicalRed300 = Color(0xFFfda4af);
  static const Color radicalRed400 = Color(0xFFfc7084);
  static const Color radicalRed500 = Color(0xFFf54260);
  static const Color radicalRed600 = Color(0xFFe21c47);
  static const Color radicalRed700 = Color(0xFFbf113b);
  static const Color radicalRed800 = Color(0xFFa01138);
  static const Color radicalRed900 = Color(0xFF891237);
  static const Color radicalRed950 = Color(0xFF4c0519);
  // dodger blue
  static const Color dodgetBlue50 = Color(0xFFeff7ff);
  static const Color dodgetBlue100 = Color(0xFFdbecfe);
  static const Color dodgetBlue200 = Color(0xFFbfdffe);
  static const Color dodgetBlue300 = Color(0xFF94cbfc);
  static const Color dodgetBlue400 = Color(0xFF61aef9);
  static const Color dodgetBlue500 = Color(0xFF4290f5);
  static const Color dodgetBlue600 = Color(0xFF266fea);
  static const Color dodgetBlue700 = Color(0xFF1e59d7);
  static const Color dodgetBlue800 = Color(0xFF1f49ae);
  static const Color dodgetBlue900 = Color(0xFF1f4089);
  static const Color dodgetBlue950 = Color(0xFF172854);

  // swatch
  static const Map<int, Color> swatch = {
    50: Color(0xFFfffbeb),
    100: Color(0xFFfff3c6),
    200: Color(0xFFffeca6),
    300: Color(0xFFffd34a),
    400: Color(0xFFffbe20),
    500: Color(0xFFf99c07),
    600: Color(0xFFdd7402),
    700: Color(0xFFb75106),
    800: Color(0xFF943d0c),
    900: Color(0xFF7a330d),
    950: Color(0xFF461902),
  };

  static const MaterialColor primeColor = MaterialColor(0xFFffeca6, swatch);
}

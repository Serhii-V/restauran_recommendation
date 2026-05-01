import 'package:flutter/cupertino.dart';

class AppLayout {
  static bool isTablet(BuildContext context) {
    final shortestSide = MediaQuery.sizeOf(context).shortestSide;
    return shortestSide >= 600;
  }

  static double bottomSheetHeightFactor(BuildContext context) {
    return isTablet(context) ? 0.45 : 0.6;
  }

  static double rowButtonsSpace(BuildContext context) {
    return isTablet(context) ? 24 : 8;
  }
}

import 'package:flutter/material.dart';

class PageSize {
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double _getHeight(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return height - padding.top - padding.bottom;
  }

  // TODO: Height as one func
  static double getThreeQuarterHeight(BuildContext context) {
    return _getHeight(context) * 0.8;
  }

  static double getThirdHeight(BuildContext context) {
    return _getHeight(context) * 0.3;
  }
}

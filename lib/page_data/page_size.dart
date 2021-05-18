import 'package:flutter/material.dart';

class PageSize {
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return height - padding.top - padding.bottom;
  }

  static double getCardHeight(BuildContext context) {
    return getHeight(context) - 138;
  }

  static double getThirdHeight(BuildContext context) {
    return getHeight(context) * 0.3;
  }
}

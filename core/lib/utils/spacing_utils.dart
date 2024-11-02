import 'package:flutter/material.dart';

const double _defaultSpacing = 16.0;

SizedBox verticalSpacing([double height = _defaultSpacing]) {
  return SizedBox(height: height);
}

SizedBox horizontalSpacing([double width = _defaultSpacing]) {
  return SizedBox(width: width);
}

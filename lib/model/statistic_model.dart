import 'package:flutter/material.dart';

class BarChartData {
  String x;
  double y;
  Color barColor;

  BarChartData({
    required this.x,
    required this.y,
    this.barColor = Colors.grey,
  });
}

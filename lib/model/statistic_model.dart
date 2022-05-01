import 'dart:ffi';

import 'package:flutter/material.dart';

@immutable
class Statistic {
  final int? stars;
  final int? averageTime;
  final int? time;
  final Array<Int>? timeSumWeek;
  final Array<Int>? timeSumMonth;

  const Statistic(
      {this.stars,
      this.averageTime,
      this.time,
      this.timeSumMonth,
      this.timeSumWeek});

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      stars: json['stars'],
      averageTime: json['averageTime'],
      time: json['time'],
      timeSumWeek: json['timeSumWeek'],
      timeSumMonth: json['timeSumMonth'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stars'] = stars;
    data['averageTime'] = averageTime;
    data['time'] = time;
    data['timeSumWeek'] = timeSumWeek;
    data['timeSumMonth'] = timeSumMonth;
    return data;
  }
}

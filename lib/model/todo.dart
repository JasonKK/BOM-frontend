import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@immutable
class Todo {
  final int? planId;
  final String planName;
  final int time;
  final bool check;
  final int repetitionType;
  final int dailyId;
  final int categoryId;

  const Todo(
      {required this.planId,
      required this.planName,
      required this.time,
      required this.check,
      required this.repetitionType,
      required this.dailyId,
      required this.categoryId});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      planId: json['planId'],
      planName: json['planName'],
      time: json['time'],
      check: json['check'],
      repetitionType: json['repetitionType'],
      dailyId: json['dailyId'],
      categoryId: json['categoryId'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['planId'] = planId;
    data['planName'] = planName;
    data['time'] = time;
    data['check'] = check;
    data['repetitionType'] = repetitionType;
    data['dailyId'] = dailyId;
    data['categoryId'] = categoryId;
    return data;
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@immutable
class Todo {
  final int planId;
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


class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []); //

  void add(String description) { // 추후 수정
    state = [
      ...state,
      Todo(
        planId: 55,
        planName: description,
        time: 0,
        repetitionType: 0,
        dailyId: 0,
        categoryId: 0,
        check: false,
      )
    ];
  }

  void toggle(int id) {
    state = [
      for (final todo in state) //
        if (todo.planId == id)
          Todo(
            planId: todo.planId,
            planName: todo.planName,
            check: !todo.check,
            categoryId: todo.categoryId,
            dailyId: todo.dailyId,
            repetitionType: todo.repetitionType,
            time: todo.time
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.planId == id)
          Todo(
              planId: todo.planId,
              planName: description,
              check: todo.check,
              categoryId: todo.categoryId,
              dailyId: todo.dailyId,
              repetitionType: todo.repetitionType,
              time: todo.time
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.planId != target.planId).toList();
  }
}



// class Todo {
//   final String id;
//   final String description;
//   final bool completed;
//
//   const Todo(
//       {required this.id, required this.description, this.completed = false});
//
//   @override
//   String toString() {
//     // TODO: implement toString
//     return 'Todo(description: $description, completed: $completed)';
//   }
// }
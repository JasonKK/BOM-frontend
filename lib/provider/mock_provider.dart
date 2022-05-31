import 'package:bom_front/repository/mock_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mock.dart';

class TodoList extends StateNotifier<List<Mock>> {
  late final MockRepository _repository; // final TodoRepository? _repository;
  final ref;

  TodoList(this._repository, this.ref, [List<Mock>? initState]) : super([]) {
    getReadTodo();
  }

  Future<void> getReadTodo() async {
    final mocks = await _repository
        .loadTodos(); // final todos = await _repository!.loadTodos();
    if (mounted) {
      // check data
      state = [...mocks];
    }
  }
}

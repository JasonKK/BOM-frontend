import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bom_front/model/todo.dart';

enum TodoListFilter { all, completed, active }

final todoListFilter = StateProvider((ref) => TodoListFilter.all);

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList([
    const Todo(id: 'tood-0', description: 'init-0'),
    const Todo(id: 'tood-1', description: 'init-1'),
    const Todo(id: 'tood-2', description: 'init-2'),
  ]);
});

final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todos;
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList(); //
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    // default:
    //   return todos;
  }
});

final currentTodo = Provider<Todo>((ref) {
  // 나중에 받을 것
  return throw UnimplementedError();
});

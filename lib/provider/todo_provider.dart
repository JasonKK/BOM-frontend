import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bom_front/model/todo.dart';
import 'package:bom_front/repository/plan_repository.dart';

enum TodoListFilter { all, completed, active }

final planStateFuture = FutureProvider<List<Todo>>((ref) async {
  TodoRepository _todoRepository = TodoRepository();
  var result = await _todoRepository.loadTodos();
  print(result);
  return result;
});

final todoListFilter = StateProvider((ref) => TodoListFilter.all);

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList();
});

final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final plans = ref.watch(todoListProvider);

  print('$plans in todo_provider.dart');

  switch (filter) {
    case TodoListFilter.all:
      return plans;
    case TodoListFilter.active:
      return plans.where((plan) => !plan.check).toList(); //
    case TodoListFilter.completed:
      return plans.where((plan) => plan.check).toList();
    // default:
    //   return todos;
  }
});

final currentTodo = Provider<Todo>((ref) {
  // 나중에 받을 것
  return throw UnimplementedError();
});

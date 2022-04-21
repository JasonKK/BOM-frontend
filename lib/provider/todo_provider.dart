import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bom_front/model/todo.dart';
import '../repository/plan_repository.dart';
import 'general_provider.dart';

enum TodoListFilter { all, completed, active }
final todoListFilter = StateProvider((ref) => TodoListFilter.all);

// final planStateFuture = FutureProvider<List<Todo>>((ref) async {
//   TodoRepository _todoRepository = TodoRepository();
//   var result = await _todoRepository.loadTodos();
//   return result;
// });
//
// final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
//   return TodoList();
// });

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  final todoData = ref.read(todoRepository);
  return TodoList(todoData);
});

class TodoList extends StateNotifier<List<Todo>> {
  late final TodoRepository _repository; // final TodoRepository? _repository;

  TodoList(this._repository, [List<Todo>? initState]) : super([]){
    getReadTodo();
  } // [] ?

  Future<void> getReadTodo() async{
   final todos = await _repository.loadTodos(); // final todos = await _repository!.loadTodos();
   if(mounted){ // check data
     state = [...todos];
   }
  }

  Future createReadPost(Todo plan) async{
    final plans = await _repository.createTodo(plan); // final plans = await _repository!.createTodo(plan);
    return plans;
  }


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
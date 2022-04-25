import 'package:bom_front/provider/todo_provider.dart';
import 'package:bom_front/repository/plan_repository.dart';
import 'package:bom_front/view/components/filter_button_widget.dart';
import 'package:bom_front/view/components/plan_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../model/todo.dart';

class Plan extends HookConsumerWidget {
  const Plan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('plan rebuilding...');
    // AsyncValue<List<Todo>> asyncTodos = ref.watch(planStateFuture); -> error 처리와 많은 양을 불러올 때 로딩필요시
    // final todos = ref.watch(todoListProvider);
    final todos = ref.watch(filteredTodos);
    print('current todos length = ${todos.length}');
    for (var i = 0; i < todos.length; i++){
      print('Each plan\'s repetitionType = ${todos[i].repetitionType}');
    }

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              flex: 2,
                child: FilterButtons()
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: ListView( // ListView.builder 또한 ok -> Listview: home에는 필요 detail에는 필요 x
                      children: [
                        for (var i = 0; i < todos.length; i++) ...[
                          if (i > 0) const SizedBox(height: 5),
                          Dismissible(
                            key: ValueKey(todos[i].planId),
                            onDismissed: (_) {
                              // print(ref.read(todoListProvider.notifier).runtimeType);
                              // 🌟 ref.read(todoListProvider.notifier).remove(todos[i]); // 삭제하기
                            },
                            child: ProviderScope(
                              overrides: [
                                currentTodo.overrideWithValue(todos[i]),
                              ],
                              child: const PlanItem(type: true),
                            ),
                          ),
                        ],
                      ],
                    ),
              ),
            ),
          ],
        ),
      );
  }
}


class hi extends StatefulWidget { // 나중에 stateful 로 빠궈서 initState 활용
  const hi({Key? key}) : super(key: key);

  @override
  State<hi> createState() => _hiState();
}

class _hiState extends State<hi> {
  TodoRepository _todoRepository = TodoRepository();
  List<Todo> dataTodo = [];
  @override
  void initState() {
    _todoRepository.loadTodos().then((value){
      setState(() => dataTodo = value);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

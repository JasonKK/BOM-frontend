import 'package:bom_front/provider/todo_provider.dart';
import 'package:bom_front/repository/plan_repository.dart';
import 'package:bom_front/view/components/filter_button_widget.dart';
import 'package:bom_front/view/components/plan_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../model/todo.dart';

class Plan extends HookConsumerWidget {
  const Plan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AsyncValue<List<Todo>> asyncTodos = ref.watch(planStateFuture); -> error 처리와 많은 양을 불러올 때 로딩필요시
    final todos = ref.watch(todoListProvider);
    // final todos = ref.watch(filteredTodos);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Expanded(
            flex: 2,
              child: FilterButtons()
          ),
          Expanded(
            flex: 6,
            child: ListView( // ListView.builder 또한 ok
                  children: [
                    const SizedBox(height: 19),
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
                          child: const PlanItem(),
                        ),
                      ),
                    ],
                  ],
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

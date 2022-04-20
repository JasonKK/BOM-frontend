import 'package:bom_front/provider/todo_provider.dart';
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
    AsyncValue<List<Todo>> asyncTodos = ref.watch(planStateFuture);
    print('$asyncTodos in plan.dart');
    // final todos = ref.watch(filteredTodos);
    // final newTodoController = useTextEditingController(); // import 'package:flutter_hooks/flutter_hooks.dart';

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
            child: asyncTodos.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('${err.toString()}')),
              data: (todos){
                return  ListView( // ListView.builder 또한 ok
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
                    // TextField(
                    //   key: addTodoKey,
                    //   controller: newTodoController,
                    //   decoration: const InputDecoration(
                    //     labelText: '추가하기',
                    //   ),
                    //   onSubmitted: (value) {
                    //     ref.read(todoListProvider.notifier).add(value);
                    //     newTodoController.clear();
                    //   },
                    // ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

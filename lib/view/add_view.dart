import 'package:bom_front/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/todo_provider.dart';

class AddPlan extends StatefulWidget {
  const AddPlan({Key? key}) : super(key: key);

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  @override
  Widget build(BuildContext context) {
    // final newTodoController = useTextEditingController(); // import 'package:flutter_hooks/flutter_hooks.dart';
    late TextEditingController title = TextEditingController();
    late TextEditingController body = TextEditingController();

    return Consumer(builder: (context, ref, child) {
      // final todos = ref.watch(todoListProvider);
      return Scaffold(
          appBar: AppBar(
            title: const Text(''),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            foregroundColor: Colors.grey,
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  // obscureText: true,
                  controller: title,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  controller: body,
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Body',
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    ref
                        .read(todoListProvider.notifier)
                        .createReadTodo(
                            planName: title.text,
                            dailyId: 4,
                            categoryId:
                                1 // 수정 필요.. id는 atuo increment인가? 줄 필요가 없나?
                            )
                        .then((val) => {
                              if (val == true)
                                {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) => AlertDialog(
                                      title: Text("응답"),
                                      content: Text("성공적!"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              title.clear();
                                              body.clear();
                                            });
                                            ref
                                                .refresh(
                                                    todoListProvider.notifier)
                                                .getReadTodo();
                                            Navigator.of(ctx).pop(); // ok
                                          },
                                          child: Text("이응"),
                                        ),
                                      ],
                                    ),
                                  )
                                }
                            });
                  },
                  child: Text('일정 생성하기'),
                )
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
            ),
          ));
    });
  }
}

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
    late TextEditingController planName = TextEditingController();
    late TextEditingController dailyId = TextEditingController();
    late TextEditingController categoryId = TextEditingController();

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
                  controller: planName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'planName',
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  controller: dailyId,
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'dailyId',
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  controller: categoryId,
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'categoryId',
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    final userPlanName = planName.text;
                    final userDailyId = int.parse(dailyId.text);
                    final userCategoryId = int.parse(categoryId.text);
                    ref
                        .read(todoListProvider.notifier)
                        .createReadTodo(
                            Todo(planName: userPlanName,
                            dailyId: userDailyId,
                            categoryId: userCategoryId))
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
                                              planName.clear();
                                              dailyId.clear();
                                              categoryId.clear();
                                            });
                                            ref
                                                .refresh(
                                                    todoListProvider.notifier)
                                                .getReadTodo(); // 필수
                                            // 아래는 삭제 네트워크 만들고 테스트하기
                                            //ref.read(todoListProvider.notifier).add(userPlanName, userDailyId, userCategoryId); // watch때문에 필요x
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

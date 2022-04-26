import 'package:bom_front/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/todo_provider.dart';

class AddPlan extends StatefulWidget {
  final bool type; // for mode(add/edit) change
  final Todo? data;

  const AddPlan({Key? key, required this.type, this.data}) : super(key: key);

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  late TextEditingController planName = TextEditingController();
  late TextEditingController dailyId = TextEditingController();
  late TextEditingController categoryId = TextEditingController();

  @override
  void initState() {
    setState(() {
      planName = TextEditingController(text: widget.data?.planName);
      dailyId = TextEditingController(text: widget.data?.dailyId.toString());
      categoryId =
          TextEditingController(text: widget.data?.categoryId.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  // obscureText: true,
                  controller: planName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'planName',
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: dailyId,
                  // obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'dailyId',
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: categoryId,
                  // obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'categoryId',
                  ),
                ),
                const SizedBox(height: 10),
                widget.type == true
                    ? TextButton(
                        onPressed: () {
                          final userPlanName = planName.text;
                          final userDailyId = int.parse(dailyId.text); // 없애돋 될듯
                          final userCategoryId =
                              int.parse(categoryId.text); // 없애돋 될듯
                          ref
                              .read(todoListProvider.notifier)
                              .editReadTodo(Todo(
                                  planName: userPlanName,
                                  dailyId: userDailyId,
                                  categoryId: userCategoryId,
                                  planId: widget.data!.planId,
                                  repetitionType: widget.data!.repetitionType,
                                  check: widget.data!.check,
                                  time: widget.data!.time))
                              .then((val) => {
                                    if (val == true)
                                      {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext ctx) =>
                                              AlertDialog(
                                            title: const Text("응답"),
                                            content: const Text("수정은 성공적!"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    planName.clear();
                                                    dailyId.clear();
                                                    categoryId.clear();
                                                  });
                                                  ref
                                                      .refresh(todoListProvider
                                                          .notifier)
                                                      .getReadTodo(); // 필수
                                                  // 아래는 삭제 네트워크 만들고 테스트하기
                                                  //ref.read(todoListProvider.notifier).add(userPlanName, userDailyId, userCategoryId); // watch때문에 필요x
                                                  Navigator.of(ctx).pop(); // ok
                                                },
                                                child: const Text("이응"),
                                              ),
                                            ],
                                          ),
                                        )
                                      }
                                    else
                                      {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext ctx) =>
                                              AlertDialog(
                                            title: const Text("응답"),
                                            content: const Text("잘못된 응답"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(); // ok
                                                },
                                                child: const Text("이응"),
                                              ),
                                            ],
                                          ),
                                        )
                                      }
                                  });
                        },
                        child: const Text('일정 수정하기'),
                      )
                    : TextButton(
                        onPressed: () {
                          final userPlanName = planName.text;
                          final userDailyId = int.parse(dailyId.text);
                          final userCategoryId = int.parse(categoryId.text);
                          ref
                              .read(todoListProvider.notifier)
                              .createReadTodo(Todo(
                                  planName: userPlanName,
                                  dailyId: userDailyId,
                                  categoryId: userCategoryId))
                              .then((val) => {
                                    if (val == true)
                                      {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext ctx) =>
                                              AlertDialog(
                                            title: const Text("응답"),
                                            content: const Text("추가는 성공적!"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    planName.clear();
                                                    dailyId.clear();
                                                    categoryId.clear();
                                                  });
                                                  ref
                                                      .refresh(todoListProvider
                                                          .notifier)
                                                      .getReadTodo(); // 필수
                                                  // 아래는 삭제 네트워크 만들고 테스트하기
                                                  //ref.read(todoListProvider.notifier).add(userPlanName, userDailyId, userCategoryId); // watch때문에 필요x
                                                  Navigator.of(ctx).pop(); // ok
                                                },
                                                child: const Text("이응"),
                                              ),
                                            ],
                                          ),
                                        )
                                      }
                                  });
                        },
                        child: const Text('일정 생성하기'),
                      ),
              ],
            ),
          ));
    });
  }
}

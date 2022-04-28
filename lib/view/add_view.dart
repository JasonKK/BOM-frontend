import 'package:bom_front/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/todo_provider.dart';
import 'components/category_widget.dart';
import 'components/repetition_widget.dart';

class AddPlan extends StatefulWidget {
  final bool type; // for mode(false: add/true: edit) change
  final Todo? data;

  const AddPlan({Key? key, required this.type, this.data}) : super(key: key);

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  // TextField에 있는 값을 가져오기 위함
  late TextEditingController planName = TextEditingController();
  late TextEditingController dailyId = TextEditingController();
  late TextEditingController categoryId = TextEditingController();

  // List<String> selectedCategory = [];
  // String all = 'All';
  // String category1 = 'category 1';
  // String category2 = 'category 2';
  // String category3 = 'category 3';
  // String category4 = 'category 4';

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
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  widget.type == true
                      ? Text('목표 수정하기',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold))
                      : Text('목표 만들기',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.0),
                  TextField(
                    // obscureText: true,
                    controller: planName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '제목을 입력해주세요',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('카테고리', style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  BomCategory(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text('+추가',
                              style: TextStyle(
                                  color: Color(0xffA876DE),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                  // Column(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: <Widget>[bomContainer()],
                  // ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('반복', style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  BomRepetition(),
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
                      //-------------------------------------------------------------------------------수정하기---------------------------------------------------------------------
                      ? TextButton(
                          onPressed: () {
                            final userPlanName = planName.text;
                            final userDailyId = int.parse(dailyId.text);
                            final userCategoryId = int.parse(categoryId.text);
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
                                                        .refresh(
                                                            todoListProvider
                                                                .notifier)
                                                        .getReadTodo(); // 필수
                                                    // 아래는 삭제 네트워크 만들고 테스트하기
                                                    //ref.read(todoListProvider.notifier).add(userPlanName, userDailyId, userCategoryId); // watch때문에 필요x
                                                    Navigator.of(ctx)
                                                        .pop(); // ok
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
                                                    Navigator.of(ctx)
                                                        .pop(); // ok
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
                      //-------------------------------------------------------------------------------추가하기---------------------------------------------------------------------
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
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
                                                          .refresh(
                                                              todoListProvider
                                                                  .notifier)
                                                          .getReadTodo(); // 필수
                                                      // 아래는 삭제 네트워크 만들고 테스트하기
                                                      //ref.read(todoListProvider.notifier).add(userPlanName, userDailyId, userCategoryId); // watch때문에 필요x
                                                      Navigator.of(ctx)
                                                          .pop(); // ok
                                                    },
                                                    child: const Text("이응"),
                                                  ),
                                                ],
                                              ),
                                            )
                                          }
                                      });
                            },
                            child: const Text('완료',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500)),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffA876DE),
                                onPrimary: Colors.white),
                          ),
                        ),
                ],
              ),
            ),
          ));
    });
  }

// 반복 이후 요일 선택시 참고하기
// Widget bomContainer() {
//   return Container(
//     padding: EdgeInsets.only(top: 4.0, left: 0.0, right: 0.0, bottom: 6.0),
//     child: Container(
//       child: Center(
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 4.0,
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 10.0, right: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   InkWell(
//                     splashColor: Colors.blue[100],
//                     onTap: () {
//                       selectedCategory.add(all);
//                       selectedCategory.add(category1);
//                       selectedCategory.add(category2);
//                       selectedCategory.add(category3);
//                       selectedCategory.add(category4);
//                       setState(() {});
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 12.0),
//                       decoration: BoxDecoration(
//                         color: selectedCategory.contains(all)
//                             ? Colors.blueAccent[100]
//                             : Colors.grey[500],
//                         borderRadius: BorderRadius.all(Radius.circular(48.0)),
//                       ),
//                       child: Text(
//                         'All',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 2.0,
//                   ),
//                   InkWell(
//                     splashColor: Colors.blue[100],
//                     onTap: () {
//                       selectedCategory = [];
//                       selectedCategory.add(category1);
//                       setState(() {});
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 12.0),
//                       decoration: BoxDecoration(
//                         color: selectedCategory.contains(category1)
//                             ? Colors.blue[100]
//                             : Colors.grey[300],
//                         borderRadius: BorderRadius.all(Radius.circular(48.0)),
//                       ),
//                       child: Text(
//                         'category 1',
//                         style: TextStyle(
//                             color: Colors.grey[900],
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 2.0,
//                   ),
//                   InkWell(
//                     splashColor: Colors.blue[100],
//                     onTap: () {
//                       selectedCategory = [];
//                       selectedCategory.add(category2);
//                       setState(() {});
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 12.0),
//                       decoration: BoxDecoration(
//                         color: selectedCategory.contains(category2)
//                             ? Colors.blue[100]
//                             : Colors.grey[300],
//                         borderRadius: BorderRadius.all(Radius.circular(48.0)),
//                       ),
//                       child: Text(
//                         'category 2',
//                         style: TextStyle(
//                             color: Colors.grey[900],
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 2.0,
//                   ),
//                   InkWell(
//                     splashColor: Colors.blue[100],
//                     onTap: () {
//                       selectedCategory = [];
//                       selectedCategory.add(category3);
//                       setState(() {});
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 12.0),
//                       decoration: BoxDecoration(
//                         color: selectedCategory.contains(category3)
//                             ? Colors.blue[100]
//                             : Colors.grey[300],
//                         borderRadius: BorderRadius.all(Radius.circular(48.0)),
//                       ),
//                       child: Text(
//                         'category 3',
//                         style: TextStyle(
//                             color: Colors.grey[900],
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 2.0,
//                   ),
//                   InkWell(
//                     splashColor: Colors.blue[100],
//                     onTap: () {
//                       selectedCategory = [];
//                       selectedCategory.add(category4);
//                       setState(() {});
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 12.0),
//                       decoration: BoxDecoration(
//                         color: selectedCategory.contains(category4)
//                             ? Colors.blue[100]
//                             : Colors.grey[300],
//                         borderRadius: BorderRadius.all(Radius.circular(48.0)),
//                       ),
//                       child: Text(
//                         'category 4',
//                         style: TextStyle(
//                             color: Colors.grey[900],
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 6.0,
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
}

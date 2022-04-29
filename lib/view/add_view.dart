import 'package:bom_front/model/todo.dart';
import 'package:bom_front/view/category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/todo_provider.dart';
import 'components/category_selection_widget.dart';
import 'components/repetition_selection_widget.dart';

class AddPlan extends ConsumerStatefulWidget {
  final bool type; // for mode(false: add/true: edit) change
  final Todo? data;

  const AddPlan({Key? key, required this.type, this.data}) : super(key: key);

  @override
  _AddPlanState createState() => _AddPlanState();
}

class _AddPlanState extends ConsumerState<AddPlan> {
  // TextField에 있는 값을 가져오기 위함
  late TextEditingController planName = TextEditingController();

  @override
  void initState() {
    ref.read(categoryIdToCreate.notifier).state = 1;
    ref.read(repetitionTypeToCreate.notifier).state = 0;

    setState(() {
      planName = TextEditingController(text: widget.data?.planName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryId = ref.watch(categoryIdToCreate);
    final repetitionTypeId = ref.watch(repetitionTypeToCreate);
    print('categoryId = $categoryId / repetitionTypeId = $repetitionTypeId');
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
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
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
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('카테고리',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    BomCategory(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryPage()));
                            },
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
                          Text('반복',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    BomRepetition(),
                    const SizedBox(height: 10),
                    widget.type == true
                        //-------------------------------------------------------------------------------수정하기---------------------------------------------------------------------
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                final userPlanName = planName.text;
                                ref
                                    .read(todoListProvider.notifier)
                                    .editReadTodo(Todo(
                                        planName: userPlanName,
                                        dailyId: widget.data?.dailyId ?? 6,
                                        // 아직 서버에서 미정
                                        categoryId: categoryId,
                                        planId: widget.data!.planId,
                                        repetitionType: repetitionTypeId,
                                        check: widget.data!.check,
                                        time: widget.data!.time))
                                    .then((val) => {
                                          if (val == true)
                                            {
                                              Navigator.pop(context),
                                              // 반환값이 없긴하는데 컴마로 구분해주는게 맞나?
                                              setState(() {
                                                planName.clear();
                                              }),
                                              ref
                                                  .refresh(
                                                      todoListProvider.notifier)
                                                  .getReadTodo(),
                                              // 필수
                                              // 아래는 삭제 네트워크 만들고 테스트하기
                                              //ref.read(todoListProvider.notifier).add(userPlanName, userDailyId, userCategoryId); // watch때문에 필요x
                                            }
                                          else
                                            {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext ctx) =>
                                                    AlertDialog(
                                                  title: const Text("응답",
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                  content: const Text(
                                                      "수정작업이 실패하였습니다."),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(); // ok
                                                      },
                                                      child: const Text("뒤로가기"),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            }
                                        });
                              },
                              child: const Text('완료',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600)),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xffA876DE),
                                  onPrimary: Colors.white,
                                  padding:
                                      EdgeInsets.symmetric(vertical: 15.0)),
                            ),
                          )
                        //-------------------------------------------------------------------------------추가하기---------------------------------------------------------------------
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                final userPlanName = planName.text;

                                ref
                                    .read(todoListProvider.notifier)
                                    .createReadTodo(Todo(
                                        planName: userPlanName,
                                        dailyId: widget.data?.dailyId ??
                                            6, // 서버에서 아직 미정
                                        categoryId: categoryId,
                                        repetitionType: repetitionTypeId))
                                    .then((val) => {
                                          if (val == true)
                                            {Navigator.pop(context)}
                                          else
                                            {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext ctx) =>
                                                    AlertDialog(
                                                  title: const Text("응답",
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                  content: const Text(
                                                      "추가작업이 실패하였습니다."),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          planName.clear();
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
                                                      child: const Text("뒤로가기"),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            }
                                        });
                              },
                              child: const Text('완료',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600)),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xffA876DE),
                                  onPrimary: Colors.white,
                                  padding:
                                      EdgeInsets.symmetric(vertical: 15.0)),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}

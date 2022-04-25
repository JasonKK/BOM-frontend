import 'package:bom_front/view/add_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // useFocus , useTextEditingController, useState, useEffect
import 'package:bom_front/provider/todo_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanItem extends StatefulHookConsumerWidget {
  final bool type; // for each page change
  const PlanItem({
    Key? key,
    required this.type
  }) : super(key: key);
  @override
  _PlanItemState createState() => _PlanItemState();
}

class _PlanItemState extends ConsumerState<PlanItem> {
  @override
  Widget build(BuildContext context) {
    print('planItem rebuilding...');
    final todo = ref.watch(currentTodo);
    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);
    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return widget.type == true ? Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Material(
          color: Colors.white,
          elevation: 3,
          borderRadius: BorderRadius.circular(4),
          child: ListTile(
            enabled: !todo.check!, // 체크시 일정 종료 (터치 불가)
            onTap: () {},
            trailing: Checkbox(
              shape: const CircleBorder(),
              activeColor: const Color(0xffA876DE),
              value: todo.check,
              onChanged: (value) => {},
            ),
            title: itemIsFocused
                ? TextField(
                    autofocus: true,
                    focusNode: textFieldFocusNode,
                    controller: textEditingController,
                  )
                : Text(todo.planName!, style: TextStyle(fontSize: 18.0)),
          ),
        )) : Container( // ------------------------------------------------------------------------------------------
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: const EdgeInsets.only(right: 20),
        child: Row(
          children: [
            Checkbox(
              shape: const CircleBorder(),
              activeColor: const Color(0xffA876DE),
              value: todo.check,
              onChanged: (value) =>
                  ref.read(todoListProvider.notifier).toggle(todo.planId!),
            ),
            Expanded(
              child: Material(
                color: Colors.white,
                elevation: 3,
                borderRadius: BorderRadius.circular(4),
                child: ListTile(
                  enabled: !todo.check!,
                  onTap: () {
                    /* start/stop timer*/
                  },
                  onLongPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPlan(
                              type: true,
                              data: todo,
                            )));
                  },
                  // 추후 카테고리 넣기 (daily)
                  trailing: Text('00:00:00'),
                  title: itemIsFocused
                      ? TextField(
                    autofocus: true,
                    focusNode: textFieldFocusNode,
                    controller: textEditingController,
                  )
                      : Text(todo.planName!, style: TextStyle(fontSize: 18.0)),
                ),
              ),
            ),
          ],
        ));
  }
}

bool useIsFocused(FocusNode node) {
  //
  final isFocused = useState(node.hasFocus);

  useEffect(() {
    void listener() {
      isFocused.value = node.hasFocus;
    }

    node.addListener(listener);
    return () => node.removeListener(listener);
  }, [node]);

  return isFocused.value;
}

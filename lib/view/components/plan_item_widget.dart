import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // useFocus , useTextEditingController, useState, useEffect
import 'package:bom_front/provider/todo_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanItem extends HookConsumerWidget {
  const PlanItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(currentTodo);
    print(todo.check);
    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);
    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          color: Colors.white,
          elevation: 3,
          borderRadius: BorderRadius.circular(4),
          child: Focus(
            //
            focusNode: itemFocusNode,
            onFocusChange: (focused) {
              if (focused) {
                textEditingController.text = todo.planName;
              } else {
                // Commit changes only when the textfield is unfocused, for performance
                // 🌟
                // ref.read(todoListProvider.notifier).edit(
                //     // 수정하기
                //     id: todo.planId,
                //     description: textEditingController.text);
                // 🌟
            }
            },
            child: ListTile(
              // enabled: false, -> 체크시 일정 종료 (+색변경) 활용
              onTap: () {
                itemFocusNode.requestFocus();
                textFieldFocusNode.requestFocus();
              },
              // 추후 카테고리 넣기 (daily)
              trailing: Checkbox(
                shape: const CircleBorder(),
                activeColor: const Color(0xffA876DE),
                value: todo.check,
                onChanged: (value) => ref.read(todoListProvider.notifier).toggle(todo.planId),
              ),
              title: itemIsFocused
                  ? TextField(
                      autofocus: true,
                      focusNode: textFieldFocusNode,
                      controller: textEditingController,
                    )
                  : Text(todo.planName),
            ),
          ),
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

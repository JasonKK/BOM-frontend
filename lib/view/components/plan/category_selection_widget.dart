import 'package:bom_front/model/category.dart';
import 'package:bom_front/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/todo_provider.dart';

class BomCategory extends ConsumerStatefulWidget {
  final Todo? data;
  final List<Category> userCategory;

  BomCategory({this.data, required this.userCategory});

  @override
  _BomCategoryState createState() => _BomCategoryState();
}

class _BomCategoryState extends ConsumerState<BomCategory> {
  late List<bool> isSelected;

  @override
  Widget build(BuildContext context) {
    isSelected = List.filled(widget.userCategory.length, false);
    int index = widget.data?.categoryId ?? 0;
    isSelected[index != 0 ? index - 1 : 0] = true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 50.0,
            child: Padding(
              padding: const EdgeInsets.only(right: 1.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ToggleButtons(
                    borderColor: Colors.transparent,
                    fillColor: Colors.transparent,
                    borderWidth: null,
                    selectedBorderColor: Colors.transparent,
                    selectedColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    children: [
                      for (var i = 0; i < widget.userCategory.length; i++) ...[
                        !isSelected[i]
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 12.0),
                                margin: EdgeInsets.only(right: 3.0),
                                decoration: BoxDecoration(
                                  color: Color(int.parse(
                                      '0x12' + widget.userCategory[i].color!)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.trip_origin,
                                      color: Colors.grey,
                                      size: 12.0,
                                    ),
                                    SizedBox(width: 1.0),
                                    Text(
                                      '${widget.userCategory[i].categoryName}',
                                      style: TextStyle(
                                          color: Colors.grey[900],
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(right: 3.0),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 12.0),
                                decoration: BoxDecoration(
                                  color: Color(int.parse(
                                      '0x26' + widget.userCategory[i].color!)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.lens,
                                      color: Color(int.parse('0xcc' +
                                          widget.userCategory[i].color!)),
                                      size: 12.0,
                                    ),
                                    SizedBox(width: 1.0),
                                    Text(
                                      '${widget.userCategory[i].categoryName}',
                                      style: TextStyle(
                                          color: Colors.grey[900],
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ],
                    onPressed: (int index) {
                      ref.read(categoryIdToCreate.notifier).state = index + 1;
                      setState(() {
                        for (int i = 0; i < isSelected.length; i++) {
                          isSelected[i] = i == index;
                        }
                      });
                    },
                    isSelected: isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

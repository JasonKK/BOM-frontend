import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../provider/todo_provider.dart';
import 'add_view.dart';
import 'components/appbar.dart';
import 'components/bottom_navigation.dart';
import 'components/calendar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'components/plan_item_widget.dart';

class HomeDetailScreen extends ConsumerStatefulWidget {
  const HomeDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeDetailScreen> createState() => _HomeDetailScreenState();
}

class _HomeDetailScreenState extends ConsumerState<HomeDetailScreen> {
  int index = 2;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(filteredTodos);
    AsyncValue<int> userStar = ref.watch(dailyUserStars);
    AsyncValue<int> dailyTimes = ref.watch(loadDailyTotalTimes);
    print('Home detail rebuilding...');
    return Scaffold(
        appBar: const BomAppBar(),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: SlidableAutoCloseBehavior(
                  child: ListView(
                    children: [
                      BomCalendar(pageCalendarFormat: CalendarFormat.week),
                      const SizedBox(height: 15.0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120.0,
                        color: const Color(0xffA876DE),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                DateFormat('yyy.MM.dd EEE', 'ko_KR')
                                    .format(DateTime.now())
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20.0)),
                            const Text("00:00:00",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 60.0)),
                          ],
                        ),
                      ),
                      Container(
                        color: const Color(0xffefefef),
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                //모서리를 둥글게 하기 위해 사용
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              elevation: 1.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          60.0,
                                      padding:
                                          const EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('과목/목표',
                                              style: TextStyle(
                                                color: Color(0xff838383),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                              )),
                                          Text('공부시간',
                                              style: TextStyle(
                                                color: Color(0xff838383),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                              ))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    for (var i = 0; i < todos.length; i++) ...[
                                      if (i > 0) const SizedBox(height: 5),
                                      ProviderScope(
                                        overrides: [
                                          currentTodo
                                              .overrideWithValue(todos[i]),
                                        ],
                                        child: const PlanItem(type: false),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              // 통계 위치
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                //모서리를 둥글게 하기 위해 사용
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              elevation: 1.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25.0),
                                child: Column(
                                  children: [
                                    Container(
                                      // width: MediaQuery.of(context).size.width -
                                      //     60.0,
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          bottom: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('통계',
                                              style: TextStyle(
                                                color: Color(0xff838383),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                              )),
                                          Text('2022년 4월 25일',
                                              style: TextStyle(
                                                color: Color(0xff838383),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.amberAccent,
                                            size: 40.0),
                                        userStar.when(
                                            data: ((data) => Text(
                                                '${data.toString()}개 획득',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0))),
                                            error: (err, stack) =>
                                                Text('Error: $err'),
                                            loading: () => Container()),
                                      ],
                                    ),
                                    SizedBox(height: 30.0),
                                    dailyTimes.when(
                                        data: ((data) => data ~/ 60 > 59
                                            ? Column(
                                                children: [
                                                  Text(
                                                      '${((data ~/ 60) ~/ 60).toString()}시간',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      '${((data ~/ 60) % 60).toString()}분',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              )
                                            : Text(
                                                '${(data ~/ 60).toString()}분',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        error: (err, stack) =>
                                            Text('Error: $err'),
                                        loading: () => Container()),
                                    const SizedBox(height: 20.0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'back',
                child: const Icon(Icons.expand_more),
                backgroundColor: const Color(0xffffffff),
                foregroundColor: Colors.grey,
                elevation: 0.0,
                mini: true,
                hoverColor: Colors.white,
                hoverElevation: 0.0,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 105.0),
              FloatingActionButton(
                heroTag: 'add',
                child: const Icon(Icons.add),
                backgroundColor: const Color(0xffA876DE),
                onPressed: () {
                  ref
                      .read(categoryIdToCreate.notifier)
                      .state = 1;
                  ref
                      .read(repetitionTypeToCreate.notifier)
                      .state = 0;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPlan(type: false)));
                },
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBarWidget(index: index));
  }
}

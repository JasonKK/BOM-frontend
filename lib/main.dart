import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:bom_front/utils.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'the plan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Planscreen(),
    );
  }
}

Widget _bottomNavigationBarWidget() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.group), label: "커뮤니티"),
      BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: "게임"),
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
      BottomNavigationBarItem(icon: Icon(Icons.work_outline), label: "캐릭터"),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "마이페이지"),
    ],
    currentIndex: 2,
    onTap: (index) {},
    selectedItemColor: Colors.deepPurple,
  );
}

class Planscreen extends StatefulWidget {
  const Planscreen({Key? key}) : super(key: key);

  @override
  State<Planscreen> createState() => _PlanscreenState();
}

class _PlanscreenState extends State<Planscreen> with TickerProviderStateMixin {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  // CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(''),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            // 좌측
            leading: IconButton(
                icon: Icon(Icons.menu, color: Colors.grey),
                onPressed: () {},
                iconSize: 30.0),
            // 우측
            actions: [
              IconButton(
                icon: Icon(Icons.verified, color: Colors.grey),
                onPressed: () {},
                iconSize: 30.0,
              )
            ]),
        body: Center(
          child: Column(
            children: [
              TableCalendar(
                locale: 'ko-KR',
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                availableCalendarFormats: {
                  CalendarFormat.month: '',
                  CalendarFormat.week: ''
                },
                calendarStyle: CalendarStyle(
                  // outsideDaysVisible: false,
                  weekendTextStyle:
                      TextStyle().copyWith(color: Colors.blue[800]),
                  holidayTextStyle:
                      TextStyle().copyWith(color: Colors.red[800]),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle().copyWith(color: Colors.red[600]),
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                calendarBuilders: CalendarBuilders(
                  // selectedBuilder: (context, date, _) {
                  //   return FadeTransition(
                  //     opacity: Tween(begin: 0.0, end: 1.0)
                  //         .animate(_animationController),
                  //     child: Container(
                  //       margin: const EdgeInsets.all(4.0),
                  //       padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                  //       color: Colors.deepOrange[300],
                  //       width: 100,
                  //       height: 100,
                  //       child: Text(
                  //         '${date.day}',
                  //         style: TextStyle().copyWith(fontSize: 16.0),
                  //       ),
                  //     ),
                  //   );
                  // },
                  todayBuilder: (context, date, _) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                      width: 100,
                      height: 100,
                      child: Image.asset('images/jake.png')
                    );
                  },
                ),
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
              ),
              Row(children: <Widget>[
                Expanded(
                    child: Divider(
                        height: 20, thickness: 0.3, color: Colors.grey)),
                Text("오늘의 목표"),
                Expanded(
                    child: Divider(
                        height: 20, thickness: 0.3, color: Colors.grey)),
              ]),
            ],
          ),
        ),
        bottomNavigationBar: _bottomNavigationBarWidget());
  }
}

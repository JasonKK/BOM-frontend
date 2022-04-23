import 'package:table_calendar/table_calendar.dart';
import 'package:bom_front/utils.dart';
import 'package:flutter/material.dart';

class BomCalendar extends StatefulWidget {
  const BomCalendar({Key? key}) : super(key: key);

  @override
  State<BomCalendar> createState() => _BomCalendarState();
}

class _BomCalendarState extends State<BomCalendar> with TickerProviderStateMixin {

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
    return TableCalendar(
      locale: 'ko-KR',
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      availableCalendarFormats: {
        CalendarFormat.month: '',
        CalendarFormat.week: ''
      },
      // headerVisible:false,
      // daysOfWeekVisible: false,
      rowHeight: 42.0,
        daysOfWeekHeight: 20.0,
        // pageAnimationEnabled:false,
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
        todayBuilder: (context, date, _) {
          return Container(
              margin: const EdgeInsets.all(4.0),
              // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              width: 100,
              height: 100,
              child: Image.asset('images/character.png'));
        },
      ),
      // 아래를 풀면 날짜 선택시 고정
      // selectedDayPredicate: (day) {
      //   // Use `selectedDayPredicate` to determine which day is currently selected.
      //   // If this returns true, then `day` will be marked as selected.
      //
      //   // Using `isSameDay` is recommended to disregard
      //   // the time-part of compared DateTime objects.
      //   return isSameDay(_selectedDay, day);
      // },
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
    );
  }
}

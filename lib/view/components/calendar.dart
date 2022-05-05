import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:bom_front/utils.dart';
import 'package:flutter/material.dart';

import '../../provider/todo_provider.dart';
import '../hom_view.dart';

class BomCalendar extends ConsumerStatefulWidget {
  late CalendarFormat pageCalendarFormat;

  BomCalendar({Key? key, required this.pageCalendarFormat}) : super(key: key);

  @override
  ConsumerState<BomCalendar> createState() => _BomCalendarState();
}

class _BomCalendarState extends ConsumerState<BomCalendar>
    with TickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now().add(const Duration(hours: 9));
  DateTime? _selectedDay;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = ref.watch(userDeviceHeight);
    final monthlyStars = ref.watch(montlyStarsProvider);

    return monthlyStars.when(data: (userMonthlyStars) => TableCalendar(
      locale: 'ko-KR',
      firstDay: kFirstDay,
      lastDay: kLastDay,
      currentDay: DateTime.now().add(const Duration(hours: 9)),
      focusedDay: _focusedDay,
      calendarFormat: widget.pageCalendarFormat,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: ''
      },
      eventLoader: (day){
        // for(var i = 0; i < userMonthlyStars.length; i++){
        //   if(userMonthlyStars[i].obtainedStar != 0){ // 별이 있는 날
        //     print('별이있는 날');
        //     return Align(
        //       alignment: Alignment.centerLeft,
        //       child:
        //       Icon(Icons.star, size: 20.0, color: Colors.yellow[600]),
        //     );
        //   }else{
        //     print('별이없는 날');
        //     return null;
        //   }
        // }

        if(userMonthlyStars.length == 0 ){ // list의 인덱스 접근 불허
          return [];
        }
        if(int.parse((userMonthlyStars[0].date)?.split('-')[1] ?? '13') == day.month){
          if(userMonthlyStars.length < day.day){ // list의 인덱스 접근 불허
            return [];
          }
          if(userMonthlyStars[day.day - 1].obtainedStar != 0){ // userMonthlyStars의 각 객체들의 date를 비교해서 맞는 경우엔 return [1]
            return [1];
          }else{
            return [];
          }
        }else{
          return [];
        }

        // if(day.day % 2 == 0){
        //   return [1];
        // }
        // return [];
      },
      // headerVisible:false,
      // daysOfWeekVisible: false,
      // rangeSelectionMode: RangeSelectionMode.disabled,
      rowHeight: deviceHeight > 2000.0 ? 42.0 : 28.0,
      daysOfWeekHeight: deviceHeight > 2000.0 ? 20.0 : 19.0,
      calendarStyle: CalendarStyle(
        // outsideDaysVisible: false,
        weekendTextStyle: const TextStyle().copyWith(color: Colors.red[800]), // 토, 일 따로 색 구분 불가
        holidayTextStyle: const TextStyle().copyWith(color: Colors.red[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: const TextStyle().copyWith(color: Colors.red[600]),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: deviceHeight > 2000.0 ? const TextStyle(fontSize: 17.0) : const TextStyle(fontSize: 15.0),
        headerPadding: deviceHeight > 2000.0 ? EdgeInsets.symmetric(vertical: 8.0) : EdgeInsets.symmetric(vertical: 0.0),
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
        markerBuilder: (context, day, events) { // 월 변경시 rebuild
          if(events.isNotEmpty){
            return Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.star, size: 20.0, color: Colors.yellow[500]),
            );
          }
          return null;
        },
      ),
      // 아래를 풀면 날짜 선택시 고정
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
        format = widget.pageCalendarFormat;
        if (widget.pageCalendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            widget.pageCalendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    ),error: (e, stackTrace) => Text('Monthly Stars Load Error : $e'), loading: () => Container());
  }
}

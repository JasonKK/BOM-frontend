import 'package:flutter/material.dart';
import 'package:weekday_selector/weekday_selector.dart'; // 기본 내장

class WeekDaySelection extends StatefulWidget {
  @override
  _WeekDaySelectionState createState() =>
      _WeekDaySelectionState();
}

class _WeekDaySelectionState extends State<WeekDaySelection> {
  final values = <bool?>[false, false, false, false, false, false, false]; // 일 월 화 수 목 금 토

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WeekdaySelector(
          shortWeekdays: ['일', '월', '화','수','목','금','토'],
          selectedColor: Colors.white,
          selectedFillColor: Color(0xffA876DE),
          shape: CircleBorder(
            side: BorderSide(color: Colors.grey.withOpacity(0.5)),

          ),
          onChanged: (v) {
            setState(() {
              values[v % 7] = !values[v % 7]!;
            });
            printIntAsDay(v);
          },
          values: values,
        ),
      ],
    );
  }
  printIntAsDay(int day) {
    print('Received integer: $day. Corresponds to day: ${intDayToEnglish(day)}. selection status : ${values[day]}');
  }

  String intDayToEnglish(int day) {
    if (day % 7 == DateTime.monday % 7) return 'Monday';
    if (day % 7 == DateTime.tuesday % 7) return 'Tueday';
    if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
    if (day % 7 == DateTime.thursday % 7) return 'Thursday';
    if (day % 7 == DateTime.friday % 7) return 'Friday';
    if (day % 7 == DateTime.saturday % 7) return 'Saturday';
    if (day % 7 == DateTime.sunday % 7) return 'Sunday';
    throw 'ERROR!: $day';
  }

}

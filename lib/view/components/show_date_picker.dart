import 'package:flutter/material.dart';

class ShowDate extends StatefulWidget {
  const ShowDate({Key? key}) : super(key: key);

  @override
  State<ShowDate> createState() => _ShowDateState();
}

class _ShowDateState extends State<ShowDate> {
  DateTime? date;
  final today = DateTime.now().add(const Duration(hours: 9));

  String getText() {
    if (date == null) {
      return '${'${today.year}/${today.month}/${today.day}'}';
    } else {
      return '${'${date!.year}/${date!.month}/${date!.day}'}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
              child: TextButton(
                child: Text(getText(), style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w400)),
                onPressed: () => pickDate(context),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ));
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now().add(const Duration(hours: 9));
    final newDate = await showDatePicker(
      locale: Locale('ko', 'KR'),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: context,
        helpText: '',
        initialDate: initialDate,
        // date ?? initialDate,
        firstDate: DateTime(initialDate.year - 5),
        lastDate: DateTime(initialDate.year + 5),
        builder: (context, child) => Theme(
          data: ThemeData().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xffA876DE),
              onPrimary: Colors.white,
              surface: Color(0xffA876DE),
              onSurface: Colors.black,
            ),
            dialogTheme: DialogTheme(),
          ),
          child: child!,
        ));
    if (newDate == null) return; // 취소 버튼 클릭

    setState(() {
      date = newDate;
    });
  }
}

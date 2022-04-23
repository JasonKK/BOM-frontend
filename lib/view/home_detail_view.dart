import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'components/appbar.dart';
import 'components/bottom_navigation.dart';
import 'components/calendar.dart';
import 'hom_view.dart';

class HomeDetailScreen extends StatefulWidget {
  const HomeDetailScreen({Key? key}) : super(key: key);

  @override
  State<HomeDetailScreen> createState() => _HomeDetailScreenState();
}

class _HomeDetailScreenState extends State<HomeDetailScreen> {
  int index = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BomAppBar(),
        body: Center(
          child: Column(
            children: [
              BomCalendar(pageCalendarFormat: CalendarFormat.week),

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.expand_less),
          backgroundColor: Color(0xffdddddd),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        bottomNavigationBar: BottomNavigationBarWidget(index: index));
  }
}

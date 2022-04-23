import 'package:bom_front/view/add_view.dart';
import 'package:bom_front/view/components/appbar.dart';
import 'package:bom_front/view/components/calendar.dart';
import 'package:bom_front/view/components/plan.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'components/bottom_navigation.dart';
import 'home_detail_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BomAppBar(),
        body: Center(
          child: Column(
            children: [
              BomCalendar(pageCalendarFormat: CalendarFormat.month),
              const SizedBox(height: 4), // to protect appBar block
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(children: const <Widget>[
                  Expanded(
                      child: Divider(
                          height: 20, thickness: 0.3, color: Colors.grey)),
                  Text("오늘의 목표"),
                  Expanded(
                      child: Divider(
                          height: 20, thickness: 0.3, color: Colors.grey)),
                ]),
              ),
              const SizedBox(height: 14),
              Expanded(flex: 1, child: Plan()),
              const SizedBox(height: 19),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.expand_more),
          backgroundColor: Color(0xffA876DE),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeDetailScreen()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBarWidget(index: index));
  }
}
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
    print('Home rebuilding...');
    return Scaffold(
        appBar: BomAppBar(),
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: BomCalendar(pageCalendarFormat: CalendarFormat.month)),
              const SizedBox(height: 4), // to protect appBar block
              Stack(
                alignment: Alignment.center,
                children: [Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(children: const <Widget>[
                    Expanded(
                        child: Divider(
                            height: 1.0, thickness: 0.3, color: Colors.grey)),
                    SizedBox(width: 70),
                    Expanded(
                        child: Divider(
                            height: 1.0, thickness: 0.3, color: Colors.grey)),
                  ]),
                ),
                  Positioned(child: Container(child: Text("오늘의 목표", style: TextStyle(color: Colors.grey))))  // Text의 고정 높이 때문에 더이상 아래 Expanded가 안늘려짐
                ],
              ),
              Expanded(
                child: Container(
                  color: Color(0xffefefef),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder( //모서리를 둥글게 하기 위해 사용
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 1.0,
                    child: Column(
                      children: [
                        const SizedBox(height: 14),
                        Expanded(flex: 1, child: Plan()),
                        const SizedBox(height: 19),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.expand_less),
          backgroundColor: Color(0xffffffff),
          foregroundColor: Colors.grey,
          hoverColor: Colors.white,
          hoverElevation: 0.0,
          elevation: 0.0,
          mini: true,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeDetailScreen()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBarWidget(index: index));
  }
}

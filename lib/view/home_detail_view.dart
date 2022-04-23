import 'package:flutter/material.dart';
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
              BomCalendar(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back),
          backgroundColor: Color(0xffA876DE),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBarWidget(index: index));
  }
}

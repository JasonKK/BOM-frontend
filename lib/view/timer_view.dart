/* this is timer_model.dart */
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bom_front/view/main_view.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  String timeString = "00:00:00";
  Stopwatch stopwatch = Stopwatch();
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Column(children: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
              child: Text("Stopwatch",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ))),
        ]));
  }
}

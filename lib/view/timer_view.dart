/* this is timer_model.dart */
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'package:bom_front/view/main_view.dart';

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'StopWatch', home: TimerPage());
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("국어모의고사 1회"),
      ),
    );
  }
}

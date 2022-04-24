/* this is timer_model.dart */
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:http/http.dart' as http;
import 'package:bom_front/view/main_view.dart';

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
          title: Text(
            "국어모의고사 1회",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ), // 나중에 과목api 받아오기
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            //뒤로가기 버튼
            icon: const Icon(Icons.arrow_back),
            tooltip: "Next page",
            onPressed: () {
              Navigator.pop(context); // 뒤로가기
            },
          )),
    );
  }
}

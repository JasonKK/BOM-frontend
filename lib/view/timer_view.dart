/* this is timer_model.dart */
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
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
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            ),
            Container(
              child: Image.asset(
                'lib/image/dog.png',
                width: 80,
                height: 80,
              ),
            ),
            Center(
              child: Container(
                width: 360,
                height: 360,
                // color: Colors.grey,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(10, 10),
                        color: Colors.black38,
                        blurRadius: 15),
                    BoxShadow(
                        offset: Offset(-10, -10),
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 15),
                  ],
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "00:00:00",
                      style:
                          TextStyle(fontSize: 80, color: Colors.grey.shade900),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

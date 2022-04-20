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
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
            child: Text("Stopwatch",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ))),
        Expanded(
          child: Container(
              width: 280,
              height: 280,
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
                      color: Colors.white.withOpacity(0.55),
                      blurRadius: 15),
                ],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "00:00:00",
                      style:
                          TextStyle(fontSize: 40, color: Colors.grey.shade900),
                    )
                  ])),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {},
                      child: Container(
                        height: 100,
                        width: 100,
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
                                color: Colors.white.withOpacity(0.85),
                                blurRadius: 15)
                          ],
                        ),
                        child: Icon(
                            stopwatch.isRunning
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 60),
                      )),
                ]))
      ]),
    );
  }
}

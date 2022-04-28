/* this is timer_model.dart */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bom_front/model/todo.dart';
import 'package:bom_front/repository/timer_repository.dart';

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'StopWatch', home: TimerPage());
  }
}

class TimerPage extends StatefulWidget {
  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Timer _timer; //타이머
  var _time = 0; //실제 늘어난 시간
  var _isRunning = false; // 시작/정지의 상태

  Todo todo = new Todo();

  void initState() {
    TimerRepository().getTimerData();
    super.initState();
    updateData();
    //해당 일정의 시간, 카테고리 색,일정 내용 가져와야함
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void updateData() {
    _time = todo.time ?? 0;
  }

  void _clickButton() {
    _isRunning = !_isRunning;

    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    int count = 0;
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
        count++;
        if (count == 30) {
          count = 0;
          TimerRepository()
              .postStarData(1); // 별개수 받아와야하는데 그거에 대해서 논의의          //별보내기
        }
      });
    });
  }

  void _pause() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[300],
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    int hours = (_time ~/ 360000).truncate();
    int minutes = (_time ~/ 6000).truncate();
    int seconds = (_time ~/ 100).truncate();

    var hour = (hours % 60).toString().padLeft(2, '0');
    var min = (minutes % 60).toString().padLeft(2, '0');
    var sec = (seconds % 60).toString().padLeft(2, '0');

    return (Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 360,
            height: 360,
            decoration: BoxDecoration(
              color: Colors.purple[200],
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white60,
                width: 5,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  right: 130,
                  child: Text(
                    "오늘\n" + "$hour:$min:$sec",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, color: Colors.white70),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Positioned(
                    child: TextButton(
                      onPressed: () => setState(() {
                        _clickButton();
                      }),
                      child: _isRunning
                          ? Icon(
                              Icons.pause,
                              size: 300,
                              color: Colors.purple.shade400,
                            )
                          : Icon(
                              Icons.play_arrow,
                              size: 300,
                              color: Colors.purple.shade400,
                            ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Positioned(
                    child: Text(
                      "$hour:$min:$sec",
                      style: TextStyle(fontSize: 80, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

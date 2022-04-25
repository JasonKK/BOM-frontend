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
  var _icon = Icons.play_arrow;
  var _Color = Colors.amber;

  late Timer _timer; //타이머
  var _time = 0; //실제 늘어난 시간
  var _isRunning = false; // 시작/정지의 상태값

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    var min = '${_time ~/ 6000}'.padLeft(2, '0');
    var sec = '${_time ~/ 100}'.padLeft(2, '0');
    var hundredth = '${_time % 100}'.padLeft(2, '0');

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                Container(
                  width: 360,
                  height: 360,
                  // color: Colors.grey,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black38,
                      width: 5,
                    ),
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
                ),
              ],
            ),
            Positioned(
              top: -20,
              right: 110,
              child: Container(
                child: Image.asset(
                  'lib/image/dog.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Positioned(
              top: 150,
              right: 30,
              child: Text(
                "$min:$sec:$hundredth",
                style: TextStyle(fontSize: 60, color: Colors.grey.shade900),
              ),
            ),
            Positioned(
              top: 100,
              right: 70,
              child: Container(
                child: Text(
                  "오늘은: 00:00:00",
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
                ),
              ),
            ),
            Positioned(
              top: 130,
              right: 80,
              child: TextButton(
                onPressed: () => setState(() {
                  _clickButton();
                }),
                child: _isRunning
                    ? Icon(
                        Icons.pause,
                        size: 100,
                      )
                    : Icon(
                        Icons.play_arrow,
                        size: 100,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
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
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause() {
    _timer.cancel();
  }
}

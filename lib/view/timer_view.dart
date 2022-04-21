/* this is timer_model.dart */
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:bom_front/view/main_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');

  return "$hours:$minutes:$seconds";
}

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
  Stopwatch stopwatch = Stopwatch();
  late Timer timer;

//   @override
//   void initState() {
//     super.initState();
//     stopwatch = Stopwatch();
//
//     fetchData();
//     timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
//       setState(() {});
//     });
//   }

  // void fetchData() async {
  //   http.Response response = await http.get("");
  //   print(response.body);
  // }

  void handleStartStop(var a) {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
            child: Text(
              "Stopwatch",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
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
                    formatTime(stopwatch.elapsedMilliseconds),
                    style: TextStyle(fontSize: 48),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    handleStartStop(stopwatch.isRunning);
                  },
                  child: Icon(
                      stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                      size: 80),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

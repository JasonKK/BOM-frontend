/* this is timer_model.dart */
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bom_front/view/main_view.dart';

class TimerPage extends StatefulWidget {
  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  String timeString = "00:00:00";
  Stopwatch stopwatch = Stopwatch();
  late Timer timer;

  void start() {
    stopwatch.start();
    timer = Timer.periodic(Duration(milliseconds: 1), update);
  }

  void update(Timer t) {
    if (stopwatch.isRunning) {
      setState(() {
        timeString =
            (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
                ":" +
                (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") +
                ":" +
                (stopwatch.elapsed.inMilliseconds % 1000 / 10)
                    .clamp(0, 99)
                    .toStringAsFixed(0)
                    .padLeft(2, "0");
      });
    }
  }

  void stop() {
    setState(() {
      timer.cancel();
      stopwatch.stop();
    });
  }

  void reset() {
    timer.cancel();
    stopwatch.reset();
    setState(() {
      timeString = "00:00:00";
    });
    stopwatch.stop();
  }

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

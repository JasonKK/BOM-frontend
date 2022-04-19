/* this is timer_model.dart */
import 'package:flutter/material.dart';
import 'package:bom_front/view/main_view.dart';
import 'package:simple_timer/simple_timer.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
    with SingleTickerProviderStateMixin {
  String _buttonState = 'OFF';
  var _color = Colors.blue;
  late TimerController _timerController;
  TimerStyle _timerStyle = TimerStyle.ring;
  TimerProgressIndicatorDirection _progressIndicatorDirection =
      TimerProgressIndicatorDirection.clockwise;
  TimerProgressTextCountDirection _textCountDirection =
      TimerProgressTextCountDirection.count_up;

  @override
  void initState() {
    //intialize timercontroller
    _timerController = TimerController(this);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
    );
  }
}

//
// class TimerPage extends StatelessWidget {
//   final Plan plan;
//
//   TimerController _timerController;
//
//   TimerPage({required Plan this.plan});
//
//
//   @override
//   void initState() {
//     _timerController = TimerController(this);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("This is Timer page"),
//         ),
//         body: ElevatedButton(
//           child: Text('id : ${plan.planId}'),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       Container(
//         child: SimpleTimer(
//           controller : _timerController,
//           duration : Duration(seconds: 10),
//         )
//       )
//     );
//   }
// }

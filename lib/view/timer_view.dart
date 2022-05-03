// /* this is timer_model.dart */
//
// import 'package:bom_front/view/components/timer_appbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:bom_front/model/todo.dart';
// import 'package:bom_front/repository/timer_repository.dart';
//
// class TimerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(title: 'StopWatch', home: TimerPage());
//   }
// }
//
// class TimerPage extends StatefulWidget {
//   @override
//   State<TimerPage> createState() => _TimerPageState();
// }
//
// class _TimerPageState extends State<TimerPage> {
//   late Timer _timer; //타이머
//   var _time = 0; //실제 늘어난 시간
//   var _isRunning = false; // 시작/정지의 상태
//
//   Todo todo = new Todo();
//
//   @override
//   void initState() {
//     TimerRepository().getTimerData();
//     super.initState();
//     updateData();
//     //해당 일정의 시간, 카테고리 색,일정 내용 가져와야함
//   }
//
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   void updateData() {
//     _time = todo.time ?? 0;
//   }
//
//   void _clickButton() {
//     _isRunning = !_isRunning;
//
//     if (_isRunning) {
//       _start();
//     } else {
//       _pause();
//     }
//   }
//
//   void _start() {
//     int count = 0;
//     _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
//       setState(() {
//         _time++;
//         count++;
//         if (count == 30) {
//           count = 0;
//           TimerRepository()
//               .postStarData(); // 별개수 받아와야하는데 그거에 대해서 논의의          //별보내기
//         }
//       });
//     });
//   }
//
//   void _pause() {
//     _timer.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TimerAppBar(),
//       backgroundColor: Color(0xffC9A0F5),
//       body: _buildbody(),
//     );
//   }
//
//   Widget _buildbody() {
//     int hours = (_time ~/ 216000).truncate();
//     int minutes = (_time ~/ 3600).truncate();
//     int seconds = (_time ~/ 60).truncate();
//
//     var hour = (hours % 60).toString().padLeft(2, '0');
//     var min = (minutes % 60).toString().padLeft(2, '0');
//     var sec = (seconds % 60).toString().padLeft(2, '0');
//
//     return (Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 360,
//             height: 360,
//             decoration: BoxDecoration(
//               color: Color(0xffA876DE),
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: Colors.white60,
//                 width: 5,
//               ),
//             ),
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: 20,
//                   right: 130,
//                   child: Text(
//                     "오늘\n" + "$hour:$min:$sec",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 25, color: Colors.white70),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Positioned(
//                     child: TextButton(
//                       onPressed: () => setState(() {
//                         _clickButton();
//                       }),
//                       child: _isRunning
//                           ? Icon(
//                               Icons.pause,
//                               size: 300,
//                               color: Color(0xff9747FF),
//                             )
//                           : Icon(
//                               Icons.play_arrow,
//                               size: 300,
//                               color: Color(0xff9747FF),
//                             ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Positioned(
//                     child: Text(
//                       "$hour:$min:$sec",
//                       style: TextStyle(fontSize: 80, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//               child: Text(
//             "허용앱 설정하러 가기",
//             style: TextStyle(
//               fontSize: 20,
//               color: Colors.white60,
//               decoration: TextDecoration.underline,
//             ),
//           ))
//         ],
//       ),
//     ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:bom_front/provider/timer_provider.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('building MyHomePage');
    return Scaffold(
      backgroundColor: Color(0xffC9A0F5),
      appBar: AppBar(title: Text('My Timer App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                color: Color(0xffA876DE),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white60,
                  width: 5,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: ButtonsContainer(),
                    top: -30,
                    right: -30,
                  ),
                  Positioned(
                    child: TimerTextWidget(),
                    top: 120,
                    right: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerModel>(
  (ref) => TimerNotifier(),
);

final _timeLeftProvider = Provider<String>((ref) {
  return ref.watch(timerProvider).timeLeft;
});

final timeLeftProvider = Provider<String>((ref) {
  return ref.watch(_timeLeftProvider);
});

class TimerTextWidget extends HookConsumerWidget {
  const TimerTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeLeft = ref.watch(timeLeftProvider);
    print('building TimerTextWidget $timeLeft');
    return Text(
      timeLeft,
      style: TextStyle(fontSize: 80, color: Colors.white),
      textAlign: TextAlign.center,
    );
  }
}

final _buttonState = Provider<ButtonState>((ref) {
  return ref.watch(timerProvider).buttonState;
});

final buttonProvider = Provider<ButtonState>((ref) {
  return ref.watch(_buttonState);
});

class ButtonsContainer extends HookConsumerWidget {
  const ButtonsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('building ButtonsContainer');

    final state = ref.watch(buttonProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state == ButtonState.initial) ...[
          StartButton(),
        ],
        if (state == ButtonState.started) ...[
          PauseButton(),
        ],
        if (state == ButtonState.paused) ...[
          StartButton(),
        ],
      ],
    );
  }
}

class StartButton extends ConsumerWidget {
  const StartButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(timerProvider.notifier).start();
        print("start pressed");
      },
      icon: Icon(
        Icons.play_arrow,
        color: Color(0xff9747FF),
      ),
      iconSize: 400,
    );
  }
}

class PauseButton extends ConsumerWidget {
  const PauseButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(timerProvider.notifier).pause();
        print("stop pressed");
      },
      icon: Icon(Icons.pause, color: Color(0xff9747FF)),
      iconSize: 400,
    );
  }
}

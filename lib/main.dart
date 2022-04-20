// import 'package:flutter/material.dart';
// import 'package:bom_front/view/main_view.dart';
//
// void main() {
//   runApp(const TimerApp());
// }
//
// class TimerApp extends StatelessWidget {
//   const TimerApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'TimerApp',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primaryColor: Colors.deepPurple,
//         ),
//         home: MainPage());
//   }
// }
import 'package:bom_front/view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:simple_timer/simple_timer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

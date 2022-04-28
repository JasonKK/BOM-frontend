import 'package:flutter/material.dart';
import 'package:bom_front/view/timer_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main page"),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.amber,
          child: Center(
              child: RaisedButton(
            child: Text("timer"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TimerPage()),
              );
            },
          ))),
    );
  }
}

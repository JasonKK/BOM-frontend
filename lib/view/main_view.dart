import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bom_front/view/timer_view.dart';
import 'package:bom_front/repositories/timer_repository.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void initState() {
    super.initState();
  }

  void getTimerInfo() async {
    TimerRepository timer_api = TimerRepository();

    var timerInfo = await timer_api.getTimerData();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return TimerPage(parseTimerData: timerInfo);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main page"),
      ),
      body: _main_button(),
    );
  }

  Widget _main_button() {
    return Center(
      child: RaisedButton(
        child: Text("Press"),
        onPressed: () {
          getTimerInfo();
        },
      ),
    );
  }
} /* 현재 코드는 mainpage 실행시 버튼을 누르면 getTimerInfo를 통해 timer_api 로 가서 timerinfo 받아온다음에 timerPage로 푸시한다 */

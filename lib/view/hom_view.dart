import 'package:bom_front/view/components/calendar.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(''),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            // 좌측
            leading: IconButton(
                icon: Icon(Icons.menu, color: Colors.grey),
                onPressed: () {},
                iconSize: 30.0),
            // 우측
            actions: [
              IconButton(
                icon: Icon(Icons.verified, color: Colors.grey),
                onPressed: () {},
                iconSize: 30.0,
              )
            ]),
        body: Center(
          child: Column(
            children: [
              bomCalendar(),
              SizedBox(height: 4), // to protect appBar block
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(children: const <Widget>[
                  Expanded(
                      child: Divider(
                          height: 20, thickness: 0.3, color: Colors.grey)),
                  Text("오늘의 목표"),
                  Expanded(
                      child: Divider(
                          height: 20, thickness: 0.3, color: Colors.grey)),
                ]),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _bottomNavigationBarWidget());
  }
}

Widget _bottomNavigationBarWidget() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.group), label: "커뮤니티"),
      BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: "게임"),
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
      BottomNavigationBarItem(icon: Icon(Icons.work_outline), label: "캐릭터"),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "마이페이지"),
    ],
    currentIndex: 2,
    onTap: (index) {},
    selectedItemColor: Colors.deepPurple,
  );
}
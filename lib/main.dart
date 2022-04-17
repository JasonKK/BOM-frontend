import 'package:flutter/material.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'the plan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Planscreen(),
    );
  }
}

Widget _bottomNavigationBarWidget(){
  return BottomNavigationBar(
    items: [
  BottomNavigationBarItem(icon: Icon(Icons.group), label: "Movie"),
      BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: "Movie"),
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.work_outline), label: "Movie"),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Movie"),
      ],
    currentIndex: 2,
    onTap: (index){},
    selectedItemColor: Colors.deepPurple,
  );
}

class Planscreen extends StatelessWidget {
  const Planscreen({Key? key}) : super(key: key);

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

          ],
        ),
      ),
        bottomNavigationBar: _bottomNavigationBarWidget()
    );
  }
}

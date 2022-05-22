import 'package:bom_front/view/quiz_page.dart';
import 'package:flutter/material.dart';

void FlutterDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Column(
            children: [
              new Text("일일 퀘스트"),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Card(
                    child: TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizPage(title: "국어"))),
                      child: Text("국어"),
                    ),
                  ),
                  Card(
                    child: TextButton(
                      onPressed: () {},
                      child: Text("수학"),
                    ),
                  ),
                  Card(
                    child: TextButton(
                      onPressed: () {},
                      child: Text("영어"),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            new FlatButton(
              child: new Text("확인"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

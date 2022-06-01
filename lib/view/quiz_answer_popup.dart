import 'package:bom_front/main.dart';
import 'package:bom_front/view/description_page.dart';
import 'package:bom_front/view/quiz_page.dart';
import 'package:flutter/material.dart';

import '../models/mock.dart';
import '../repository/mock_repository.dart';

void AnswerPopup(BuildContext context, String text, String answer, int trial) {
  if (text == answer) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Column(
              children: [
                new Text("정답입니다"),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("보상, 별 15개"),
              ],
            ),
            actions: [
              new FlatButton(
                child: new Text("해설"),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DescriptionPage(title: "해설"))),
              ),
              new FlatButton(
                child: new Text("홈화면으로 가기"),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: "해설"))),
              ),
            ],
          );
        });
  } else {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Column(
              children: [
                new Text("틀렸습니다."),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$trial/3회 시도하셨습니다."),
              ],
            ),
            actions: [
              FlatButton(
                  child: new Text("재시도"),
                  onPressed: () {
                    MockRepository().fetchMock();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizPage(title: "국어")));
                  }),
              FlatButton(
                child: new Text("홈화면으로 가기"),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: "해설"))),
              ),
            ],
          );
        });
  }
}

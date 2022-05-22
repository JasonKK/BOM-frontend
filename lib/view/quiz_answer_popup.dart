import 'package:bom_front/view/quiz_page.dart';
import 'package:flutter/material.dart';

void AnswerPopup(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Column(
            children: [
              new Text("정답입니다"),
            ],
          ),
          content: Column(
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
                      builder: (context) => QuizPage(title: "해설"))),
            ),
            new FlatButton(
              child: new Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

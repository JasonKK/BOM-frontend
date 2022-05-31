import 'dart:convert';

import 'package:bom_front/view/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/mock.dart';

void quizPop(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Column(
            children: [
              new Text("일일퀘스트"),
            ],
          ),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("국어"),
                    Image.asset(
                      'lib/images/present.png',
                      width: 100,
                      height: 100,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuizPage(title: "국어")));
                      },
                      child: Text("열기"),
                      color: Colors.limeAccent,
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("수학"),
                    Image.asset(
                      'lib/images/present.png',
                      width: 100,
                      height: 100,
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text("열기"),
                      color: Colors.limeAccent,
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("영어"),
                    Image.asset(
                      'lib/images/present.png',
                      width: 100,
                      height: 100,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuizPage(title: "국어")));
                      },
                      child: Text("열기"),
                      color: Colors.limeAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

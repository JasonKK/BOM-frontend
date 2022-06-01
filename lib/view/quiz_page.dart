import 'dart:convert';
import 'dart:io';

import 'package:bom_front/repository/mock_repository.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '../models/mock.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextEditingController _answerController = new TextEditingController();
  late Future<List<Mock>> futuremock;
  String? realanswer;
  String? description;

  void initState() {
    super.initState();
    futuremock = MockRepository().loadTodos();
  }

  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<List<Mock>>(
              future: futuremock,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  realanswer = snapshot.data![6].answer;
                  description = snapshot.data![6].explanation;
                  return Image.network(snapshot.data![6].questionImage!);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: _answerController,
              onSubmitted: (text) {
                checkAnswer(text);
              },
              decoration: InputDecoration(
                hintText: "답을 입력해주세요",
                border: OutlineInputBorder(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkAnswer(String text) {
    print(realanswer);
    if (text == realanswer) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                new Text("정답입니다!"),
                Image.network(description!),
              ],
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("틀렸습니다!"),
          );
        },
      );
    }
    print(text);
  }
}

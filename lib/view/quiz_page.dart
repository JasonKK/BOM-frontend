import 'dart:convert';
import 'dart:io';

import 'package:bom_front/repository/mock_repository.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '../models/mock.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _answerController = TextEditingController();
  late Future<List<Mock>> futuremock;

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
                  // return Text(snapshot.data![2].questionImage!);
                  return Image.network(snapshot.data![4].questionImage!);
                } else {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              width: 350,
              height: 500,
            ),
            Container(
              width: 300,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "입력해주세요";
                  }
                },
                controller: _answerController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '답 입력',
                ),
                // onChanged: (text) {
                //   StreamBuilder<List<Mock>>(
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         print("Success");
                //         if (snapshot.data![2].answer! != text) {
                //           print("Wrong answer");
                //         } else {
                //           print("Correct answer");
                //         }
                //       } else {
                //         return Text('${snapshot.error}');
                //       }
                //       return const CircularProgressIndicator();
                //     },
                //   );
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bom_front/main.dart';
import 'package:bom_front/repository/mock_repository.dart';
import 'package:bom_front/view/quiz_answer_popup.dart';
import 'package:flutter/material.dart';
import '../models/mock.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final TextEditingController _answerController = new TextEditingController();
  late Future<List<Mock>> futuremock;
  String? realanswer;
  String? description;

  void initState() {
    super.initState();
    futuremock = MockRepository().loadMocks();
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
                  return Image.network(snapshot.data![6].explanation!,
                      width: double.infinity);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            SizedBox(
              height: 40,
            ),
            new FlatButton(
              child: new Text("홈으로 돌아가기"),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(title: "초기화면"))),
            ),
          ],
        ),
      ),
    );
  }
}

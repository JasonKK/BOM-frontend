import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<PlatformFile> _files = [];

  void _pickFiles() async {
    List<PlatformFile>? uploadedFiles = (await FilePicker.platform.pickFiles(
      allowMultiple: true,
    ))
        ?.files;

    setState(() {
      for (PlatformFile file in uploadedFiles!) {
        _files.add(file);
      }
    });
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
            ElevatedButton(
              onPressed: _pickFiles,
              child: Text("Choose a file"),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              width: 350,
              height: 500,
              child: Scrollbar(
                  isAlwaysShown: true,
                  child: ListView.builder(
                    itemCount: _files.isEmpty ? 1 : _files.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _files.isEmpty
                          ? const ListTile(
                              title:
                                  Text("파일을 업로드해주세요 - 한 번에 여러 파일을 업로드할 수 있습니다"))
                          : ListTile(
                              title: Text(_files.elementAt(index).name),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _files.removeAt(index);
                                  });
                                },
                              ),
                            );
                    },
                  )),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Upload to S3"),
            ),
          ],
        ),
      ),
    );
  }
}

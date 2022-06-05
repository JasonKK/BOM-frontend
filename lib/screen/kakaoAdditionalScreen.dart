import 'package:flutter/material.dart';

class additionalPage extends StatelessWidget {
  const additionalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: kakaoAdditionalPage());
  }
}

class kakaoAdditionalPage extends StatefulWidget {
  const kakaoAdditionalPage({Key? key}) : super(key: key);

  @override
  State<kakaoAdditionalPage> createState() => _kakaoAdditionalPageState();
}

class _kakaoAdditionalPageState extends State<kakaoAdditionalPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController introductionController = TextEditingController();
    TextEditingController phonenumController = TextEditingController();

    return Scaffold();
  }
}

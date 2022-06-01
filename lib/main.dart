import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'kakaoLogin.dart';

void main() {
  KakaoSdk.init(
      nativeAppKey: 'e90865b33f82b549a1c0c0c784221503',
      javaScriptAppKey: "d56096838102c2292bc2fa305a58d261");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KakaoLogin',
      home: KakaoLoginPage(),
    );
  }
}

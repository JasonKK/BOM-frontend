import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'kakaologinScreen.dart';
import 'login_button.dart';
import 'package:http/http.dart' as http;

class OnlyKakaoLogin extends StatefulWidget {
  const OnlyKakaoLogin({Key? key}) : super(key: key);

  @override
  _OnlyKakaoLoginState createState() => _OnlyKakaoLoginState();
}

class _OnlyKakaoLoginState extends State<OnlyKakaoLogin> {
  bool _isKakaoTalkInstalled = false;

  var validateToken;

  @override
  void initState() {
    super.initState();
    initKakaoTalkInstalled();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () =>
            loginWithKakao(), //_isKakaoTalkInstalled ? loginWithTalk() : loginWithKakao(),
        child: loginButton(context, 'images/kakao_icon.png', 'Only Kakao login',
            Colors.black87, Colors.yellow.withOpacity(0.7), Colors.yellow));
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode: authCode);
      print("로그인 성공 ${token.accessToken}");
    } catch (error) {
      print("로그인 실패 $error");
    }
  }

  _loggingout() async {
    try {
      await UserApi.instance.logout();
      print("로그아웃 성공, SDK에서 토큰 삭제");
    } catch (error) {
      print("로그아웃 실패!");
    }
  }

  myInfo() async {
    try {
      User user = await UserApi.instance.me();
      print("사용자 정보 요청 성공"
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print("사용자 정보 요청 실패 $error");
    }
  }

  _postRequest(var token) async {
    final url = Uri.parse(
        'http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com/auth/login');
    print("post() url: $url");

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'platform': 'kakao', 'accessToken': '$token'},
    );
  }

  loginWithKakao() async {
    try {
      print("entered loginWithKakao");
      // var code = await AuthCodeClient.instance.request();
      // await _issueAccessToken(code);
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      print("카카오톡 로그인 성공 ${token.accessToken}");
      var temptoken = token.accessToken;
      _postRequest(temptoken);

      myInfo();
    } catch (e) {
      print(e.toString());
      print("can't enter");
    }
  }

  loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print(e.toString());
    }
  }

  initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('kakao Install : ' + installed.toString());

    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  Future<void> _loginButtonPressed() async {
    String authCode = await AuthCodeClient.instance.request();
    print(authCode);
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../model/token.dart';
import 'kakaologinScreen.dart';
import '../utils/login_button.dart';
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
        onTap: () => _isKakaoTalkInstalled ? loginWithKakao() : loginWithTalk(),
        child: loginButton(context, 'images/kakao_icon.png', 'Only Kakao login',
            Colors.black87, Colors.yellow.withOpacity(0.7), Colors.yellow));
  }

  //token
  _tokenAccessOkay(String authCode) async {
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print("토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}");
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print("토큰 만료 $error");
          // _refreshToken(refreshtoken)
        } else {
          print("토큰 정보 조회 실패 $error");
        }
      }
    }
  }

  // 카카오에서 받은 토큰 'post'방식으로 전달
  Future<Token> _postRequest(var kakaotoken) async {
    final url = Uri.parse(
        'http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com/auth/login');
    print("post() url: $url");

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'platform': 'kakao', 'accessToken': '$kakaotoken'},
    );

    if (response.statusCode == 200) {
      print("응답했디");
      print(json.decode(response.body));
      return Token.fromJson(json.decode(response.body));
    } else {
      throw Exception("실패!");
    }

    print(response.body);
  }

  _refreshToken(var refreshtoken) async {
    final url = Uri.parse(
        'http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com/auth/new');
    print("Give me Access Token: $url");

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{"refreshToken": "$refreshtoken"},
    );

    print("I Got new AccessCode!! " + response.body);
  }

//카카오톡이 기존에 설치되어있을때 사용
  loginWithKakao() async {
    try {
      print("entered loginWithKakao");
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      print("카카오톡 로그인 성공 ${token.accessToken}");
      var temptoken = token.accessToken;
      _postRequest(temptoken);
      _tokenAccessOkay(temptoken);
    } catch (e) {
      print(e.toString());
      print("can't enter");
    }
  }

  //카카오톡이 설치가 안되어있을때 용용
  loginWithTalk() async {
    try {
      print("entered loginWithKakao web");
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      print("카카오톡 로그인 성공 ${token.accessToken}");
      var temptoken = token.accessToken;
      _postRequest(temptoken);
      _tokenAccessOkay(temptoken);
    } catch (e) {
      print(e.toString());
    }
  }

//초기에 설치가 되어있는지 확인
  initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('kakao Install : ' + installed.toString());
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }
}

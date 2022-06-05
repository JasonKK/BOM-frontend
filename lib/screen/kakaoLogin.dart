import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../utils/login_button.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginMainPage(),
    );
  }
}

class LoginMainPage extends StatefulWidget {
  const LoginMainPage({Key? key}) : super(key: key);

  @override
  _OnlyKakaoLoginState createState() => _OnlyKakaoLoginState();
}

class _OnlyKakaoLoginState extends State<LoginMainPage> {
  bool _isKakaoTalkInstalled = false;

  var kakaoToken;
  var accessToken;
  var refreshToken;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initKakaoTalkInstalled();
    LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Login Page',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password',
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      print(nameController.text);
                      print(passwordController.text);
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  child: CupertinoButton(
                      onPressed: () => _isKakaoTalkInstalled
                          ? loginWithKakao()
                          : loginWithTalk(),
                      color: Colors.yellow,
                      child: Text('카카오 로그인',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          )))),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }

  //token
  _tokenAccessOkay(String authCode) async {
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print("카카오 토큰 유효성 체크 성공 ");
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print("토큰 만료");
          _getrefreshToken(refreshToken);
        } else {
          print("토큰 정보 조회 실패 $error");
        }
      }
    }
  }

  // 카카오에서 받은 토큰 'post'방식으로 전달
  _postRequest(var kakaotoken) async {
    final url = Uri.parse(
        'http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com/auth/login');
    print("Give me access, refresh Token!");

    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'platform': 'kakao', 'accessToken': '$kakaotoken'},
    );

    String jsonData = response.body;
    accessToken = jsonDecode(jsonData)['payload']['accessToken'];
    refreshToken = jsonDecode(jsonData)['payload']['refreshToken'];
  }

  _getrefreshToken(var refreshtoken) async {
    final url = Uri.parse(
        'http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com/auth/new');
    print("Give me Access Token!");

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{"refreshToken": "$refreshtoken"},
    );

    print("I Got new AccessCode!! ");

    String jsonData = response.body;
    accessToken = jsonDecode(jsonData)['payload']['accessToken'];
  }

//카카오톡이 기존에 설치되어있을때 사용
  loginWithKakao() async {
    try {
      print("entered loginWithKakao");
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      print("카카오톡 로그인 성공");
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
      print("설치가 안된 카카오톡 로그인 성공! ${token.accessToken}");
      kakaoToken = token.accessToken;
      _postRequest(kakaoToken);
      _tokenAccessOkay(kakaoToken); // refreshtoken 생성 및
      _getInfo();
    } catch (e) {
      print(e.toString());
    }
  }

  _getInfo() async {
    try {
      User user = await UserApi.instance.me();
      print('시용지 정보 요청 성공 ${user.id}');
    } catch (error) {
      print('$error');
    }
  }

//초기에 설치가 되어있는지 확인
  initKakaoTalkInstalled() async {
    final installed = await _isKakaoTalkInstalled;
    print('kakao Install');
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }
}

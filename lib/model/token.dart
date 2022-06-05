import 'package:flutter_riverpod/flutter_riverpod.dart';

class Info {
  String? emailId;
  int? grade;
  String? password;
  String? userName;
  String? phoneNum;
  DateTime? birth;
  String? nickname;
  String? introduction;

  Info({
    this.emailId,
    this.grade,
    this.password,
    this.userName,
    this.phoneNum,
    this.birth,
    this.nickname,
    this.introduction,
  });

  Info.fromJson(Map<String, dynamic> json) {
    emailId = json['emailId'];
    grade = json['grade'];
    password = json['password'];
    userName = json['userName'];
    phoneNum = json['phoneNum'];
    birth = json['birth'];
    nickname = json['nickname'];
    introduction = json['introduction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emailId'] = this.emailId;
    data['grade'] = this.grade;
    data['password'] = this.password;
    data['userName'] = this.userName;
    data['phoneNum'] = this.phoneNum;
    data['birth'] = this.birth;
    data['nickname'] = this.nickname;
    data['introduction'] = this.introduction;
    return data;
  }
}

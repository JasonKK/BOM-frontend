import 'dart:convert';
import '../model/todo.dart';
import 'package:http/http.dart' as http;

class TimerRepository {
  static const urlApi =
      'http://ec2-3-39-177-232.ap-northeast-2.compute.amazonaws.com';

  Future<Todo> getTimerData() async {
    print("this is for get category color, plan name, time");

    final http.Response response = await http.get(Uri.parse(urlApi + ''));

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load timerdata");
    }
  }

  Future<dynamic> getUserData() async {
    http.Response response = await http.get(Uri.parse(urlApi + 'plan:planId'));
    if (response.statusCode == 200) {
      var parsingData = jsonDecode(response.body);
      return parsingData;
    } else {
      print("ERROR by this status : ${response.statusCode}");
    }
  }

  Future<dynamic> getTotalTimeData(DateTime time, Todo model) async {
    http.Response response = await http
        .get(Uri.parse(urlApi + '/plan/total?date=${time.day}&userId=1'));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    } else {
      print("ERROR by this status : ${response.statusCode}");
    }
  }

  Future<dynamic> postTimeData(List<String> data, String name) async {
    try {
      Map<String, dynamic> data = {'dailyId': 'dailyId', 'time': 'time'};

      var body = json.encode(data);

      http.Response response = await http.post(Uri.parse(urlApi),
          headers: {"Content-Type": "application/json"}, body: body);
    } catch (e) {
      print(e);

      return null;
    }
  }

  Future<dynamic> postStarData(String data, int count) async {
    try {
      Map<String, dynamic> data = {'star': null};

      var body = json.encode(data);

      http.Response response = await http.post(Uri.parse(urlApi),
          headers: {"Content-Type": "application/json"}, body: body);
    } catch (e) {
      print(e);

      return null;
    }
  }
}

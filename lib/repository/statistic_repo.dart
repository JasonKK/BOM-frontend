import 'dart:convert';
import 'package:bom_front/model/statistic_model.dart';

import '../model/todo.dart';
import 'package:http/http.dart' as http;

class StatisticRepository {
  static const urlApi =
      'http://ec2-3-39-10-54.ap-northeast-2.compute.amazonaws.com';

  /*하루 시간 가져오는 코드 */
  Future<Statistic> getDailyTime() async {
    print("this is for get daily time data");
    final http.Response response = await http
        .get(Uri.parse(urlApi + '/plan/total?date=2022-04-26&userId=1'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['averageTime'] == null) {
        print('Error! because averageTime is empty');
      }
      return body['averageTime'];
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load timerdata");
    }
  }

  /*한주의 별개수 가져오는 코드 */
  Future<Statistic> getWeekStar() async {
    print("this is for get week star data");
    final http.Response response = await http
        .get(Uri.parse(urlApi + '/plan/week/star?date=2022-04-27&userId=2'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['stars'] == null) {
        print('Error! because star is empty');
      }
      return body['stars'];
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load star data");
    }
  }

  /*한달의 별개수 가져오는 코드 */
  Future<Statistic> getMonthstar() async {
    print("this is for get month star data");
    final http.Response response = await http
        .get(Uri.parse(urlApi + '/plan/month/star?date=2022-04-27&userId=2'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['stars'] == null) {
        print('Error! because plan is empty');
      }
      return body['stars'];
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load star data");
    }
  }

/*한주의 시간 가져오는 코드 */
  Future<Statistic> getWeekTime() async {
    print("this is for get week time data");
    final http.Response response = await http
        .get(Uri.parse(urlApi + '/plan/week/average?date=2022-04-27&userId=2'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['averageTime'] == null) {
        print('Error! because averageTime is empty');
      }
      return body['averageTime'];
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load time data");
    }
  }

/*한달의간시간 가져오는 코드 */
  Future<Todo> getMonthTime() async {
    print("tthis is for get month time data");
    final http.Response response = await http.get(
        Uri.parse(urlApi + '/plan/month/average?date=2022-04-27&userId=2'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['averageTime'] == null) {
        print('Error! because averageTime is empty');
      }
      return body['averageTime'];
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load time data");
    }
  }

  Future<Statistic> getWeekTimeChart() async {
    print("this is for get week time ");
    final http.Response response = await http
        .get(Uri.parse(urlApi + '/plan/week/total?date=2022-04-27&userId=2'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['averageTime'] == null) {
        print('Error! because averageTime is empty');
      }
      return body['averageTime'];
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load time data");
    }
  }

  Future<Statistic> getMonthTimChart() async {
    print("this is for get month time ");
    final http.Response response = await http
        .get(Uri.parse(urlApi + '/plan/month/total?date=2022-04-27&userId=2'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['averageTime'] == null) {
        print('Error! because averageTime is empty');
      }
      return body['averageTime'];
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load time data");
    }
  }
}
/*
미구현 -> 날짜별 get 해와서 해당 차트안에 넣는것
 */

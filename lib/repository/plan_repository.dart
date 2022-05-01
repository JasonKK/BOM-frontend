import 'dart:convert';
import 'package:bom_front/utils.dart';
import '../model/todo.dart';
import 'package:http/http.dart' as http;

class TodoRepository {
  static const urlApi =
      'http://ec2-3-39-177-232.ap-northeast-2.compute.amazonaws.com';

  Future<List<Todo>> loadTodos() async {
    print('Fetch plan data...');
    var url = Uri.parse(urlApi + '/plan/all?date=${getToday()}&userId=1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      // var body = jsonDecode(response.body) as List<dynamic>;
      Map<String, dynamic> body = json.decode(response.body);
      // print('body => $body');
      if (body['plans'] == null) {
        // opcode의 청체 파악 후 적용하기
        print('error because plan is empty');
      }

      List<dynamic> list = body['plans'];
      // print('todolist => $list');
      return list.map<Todo>((plan) => Todo.fromJson(plan)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }

  Future createTodo(Todo todos) async {
    var url = Uri.parse(urlApi + '/plan');
    var response = await http.post(url,
        body: json.encode({
          "planName": todos.planName,
          "categoryId": todos.categoryId,
          "userId": 1, // 추후 변경 하기
          "date": '${getToday()}',
          "repetitionType": todos.repetitionType,
        }),
        headers: <String, String>{'Content-type': 'application/json'});
    print('createTodo => ${response.body}');
    if (response.body == null) {
      print('error with createTodo response');
    }
    if (response.body.isNotEmpty) {
      return true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  Future editTodo(Todo todos) async {
    var url = Uri.parse(urlApi + '/plan/' + '${todos.planId}');
    var response = await http.patch(url,
        body: jsonEncode(todos),
        headers: <String, String>{'Content-type': 'application/json'});
    // print(response.body);
    // print(response.headers);
    // print(response.statusCode);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 404) {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    } else {
      return true;
    }
  }

  Future deleteTodo(id) async {
    var url = Uri.parse(urlApi + '/plan/' + '$id');
    var response = await http.delete(url);
    print('delete success!');
    if (response.statusCode >= 404) {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    } else {
      return true;
    }
  }

  Future<int> loadStars() async {
    print('Fetch star data...');
    var url = Uri.parse(urlApi + '/plan/star?date=${getToday()}&userId=1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['star'] == null) {
        print('Error! because plan is empty');
      }
      return body['star'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }

  Future<int> loadDailyTotalTimes() async {
    print('Fetch daily total times data...');
    var url = Uri.parse(urlApi + '/plan/total?date=${getToday()}&userId=1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['totalTime'] == null) {
        print('Error! because plan is empty');
      }
      return body['totalTime'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }
// 프론트단에서 처리하므로 필요 x
// Future toggleCheck(Todo todos) async {
//   var url = Uri.parse(urlApi + '/plan/' + '${todos.planId}' + '/check');
//   var response = await http.patch(url,
//       // body: jsonEncode(todos),
//       headers: <String, String>{'Content-type': 'application/json'});
//   // print(response.body);
//   // print(response.headers);
//   // print(response.statusCode);
//   if (response.body == null) {
//     print('error with get');
//   }
//   if (response.statusCode == 404) {
//     print('Request failed with status: ${response.statusCode}.');
//     return false;
//   } else {
//     return true;
//   }
// }
}

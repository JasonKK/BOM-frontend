import 'dart:convert';
import 'package:bom_front/utils.dart';
import '../model/todo.dart';
import 'package:http/http.dart' as http;

class TodoRepository{
  Future<List<Todo>> loadTodos() async{
    // var url = Uri.parse('http://ec2-3-39-177-232.ap-northeast-2.compute.amazonaws.com/plan/all?date=${getToday()}&userId=1');
    var url = Uri.parse('http://ec2-3-39-177-232.ap-northeast-2.compute.amazonaws.com/plan/all?date=2022-04-18&userId=1');
    var response = await http.get(url);
    if(response.body == null){
      print('error with get');
    }
    if(response.statusCode == 200){
      Map<String, dynamic> body = json.decode(response.body);
      // print('body => $body');
      if(body['plans'] == null){
        print('error because plan is empty');
      }

      List<dynamic> list = body['plans'];
      // print('todolist => $list');
      return list.map<Todo>((plan) => Todo.fromJson(plan)).toList();
    }else{
      throw Exception('Can\'t get plans');
    }
  }

}
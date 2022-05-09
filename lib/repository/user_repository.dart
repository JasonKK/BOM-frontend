import 'dart:convert';
import 'package:bom_front/model/category.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class UserRepository{
  static const urlApi =
      'http://ec2-3-39-10-54.ap-northeast-2.compute.amazonaws.com';

  Future<User> loadUser() async {
    print('Fetch User\'s data...');
    var url = Uri.parse(urlApi + '/user/1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      print('body => $body');
      if (body['getUserResult'] == null) {
        print('error because plan is empty');
      }

      return User.fromJson(body['getUserResult']);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }

  Future<List<Category>> loadUserCategory() async {
    print('Fetch User\'s Category data...');
    var url = Uri.parse(urlApi + '/category/user?userId=1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      print('body => $body');
      if (body['category'] == null) {
        print('error because plan is empty');
      }
      List<dynamic> list = body['category'];
      return list.map<Category>((category) => Category.fromJson(category)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }


}
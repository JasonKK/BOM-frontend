import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class UserRepository{
  static const urlApi =
      'http://ec2-3-39-177-232.ap-northeast-2.compute.amazonaws.com';

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
      if (body['plans'] == null) {
        print('error because plan is empty');
      }

      return User.fromJson(body['getUserResult']);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }
}
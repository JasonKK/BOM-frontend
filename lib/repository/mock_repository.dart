import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/mock.dart';

const urlApi = 'http://ec2-3-39-10-54.ap-northeast-2.compute.amazonaws.com';

Future<List<Mock>> loadTodos() async {
  print('Fetch plan data...');
  var url = Uri.parse(urlApi + '/mock?grade=1&subject=2');
  var response = await http.get(url);
  if (response.body == null) {
    print('error with get');
  }
  if (response.statusCode == 200) {
    Map<String, dynamic> body = json.decode(response
        .body); // var body = jsonDecode(response.body) as List<dynamic>;
    if (body['result'] == null) {
      // opcode의 청체 파악 후 적용하기
      print('error because plan is empty');
    }
    List<dynamic> list = body['result'];
    return list.map<Mock>((plan) => Mock.fromJson(plan)).toList();
  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Can\'t get plans');
  }
}

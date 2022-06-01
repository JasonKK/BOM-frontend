import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/mock.dart';

class MockRepository {
  static const urlApi =
      'http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com';

  Future<List<Mock>> loadMocks() async {
    print('Fetch mock data...');
    var url = Uri.parse(urlApi + '/mock?grade=2&subject=영어');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response
          .body); // var body = jsonDecode(response.body) as List<dynamic>;
      if (body["Questions"] == null) {
        print('error because mock is empty');
      }
      List<dynamic> list = body['Questions'];
      return list.map<Mock>((plan) => Mock.fromJson(plan)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get mock');
    }
  }
}

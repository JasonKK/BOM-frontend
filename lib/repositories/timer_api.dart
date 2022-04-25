import 'package:http/http.dart' as http;
import 'dart:convert';

class Timer_API {
  final String url;

  Timer_API(this.url);

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
}

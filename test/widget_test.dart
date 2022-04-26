import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String param = 'hi';

void main() {

  initializeDateFormatting('ko_KR', null).then((_) => runMyCode());
  print(param);

  // Intl.defaultLocale = 'ko_KR';


  // final now = DateTime.now();
  // DateFormat formatter = DateFormat('yyy.MM.dd EEE');
  // String strToday = formatter.format(now);
  // print(strToday);
}

runMyCode() {
  print('BOM BOM BOM BOM ~ BOM이 왔어용...~');
  String p = DateFormat('yyy.MM.dd EEE', 'ko_KR').format(DateTime.now());
  param = p;
  print(param);
}
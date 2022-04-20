import 'package:intl/intl.dart';

void main(){
  print('BOM BOM BOM BOM ~ BOM이 왔어용...~');
  final now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String strToday = formatter.format(now);
  print(strToday);


}
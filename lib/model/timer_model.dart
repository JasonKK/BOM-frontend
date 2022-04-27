/* this is timer_model.dart */

// class Timer {
//   int? planId;
//   int time = 0;
//
//   Timer(this.planId, this.time);
//
//   Timer.fromJson(Map<String, dynamic> timerMap) {
//     planId = timerMap['planId'] ?? 0;
//     time = timerMap['time'] ?? 0;
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'planId': planId, 'time': time};
//   }
// }

import 'package:http/http.dart' as http;

//http://ec2-3-39-177-232.ap-northeast-2.compute.amazonaws.com/
class HttpHelper {

  final String domain = 'http://ec2-3-39-177-232.ap-northeast-2.compute.amazonaws.com';
  final String path = ''

}

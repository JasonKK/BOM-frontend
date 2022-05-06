import 'package:bom_front/provider/statistic_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/statistic_model.dart';

class dailyAvgData extends ConsumerWidget {
  Statistic statistic_data = new Statistic();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final week_times = ref.watch(userWeekTimeProvider);
    final week_stars = ref.watch(userWeekStarProvider);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "평균 공부 시간",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "$week_times",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "별 획득 개수",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "$week_stars",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

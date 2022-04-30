import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

enum SegmentType { week, month }

class plan_toggle_button extends StatelessWidget {
  const plan_toggle_button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: CustomSlidingSegmentedControl<SegmentType>(
          initialValue: SegmentType.week,
          isStretch: true,
          children: {
            SegmentType.week: Text(
              '주',
              textAlign: TextAlign.center,
            ),
            SegmentType.month: Text(
              '월',
              textAlign: TextAlign.center,
            ),
          },
          innerPadding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(14),
          ),
          thumbDecoration: BoxDecoration(
            color: Color(0xffA876DE),
            borderRadius: BorderRadius.circular(12),
          ),
          onValueChanged: (v) {
            print(v);
          },
        ),
      ),
    );
  }
}

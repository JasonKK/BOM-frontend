import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/statistic_provider.dart';
import 'daily_avg_data.dart';
import 'month_avg_data.dart';

enum SegmentType { week, month }

final segmentType = StateProvider((ref) => SegmentType.week);

class togglebuttonState extends HookConsumerWidget {
  int? value;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            if (v == SegmentType.week) {
              ref.read(segmentType.notifier).state = SegmentType.week;
            } else {
              ref.read(segmentType.notifier).state = SegmentType.month;
            }
          },
        ),
      ),
    );
  }
}

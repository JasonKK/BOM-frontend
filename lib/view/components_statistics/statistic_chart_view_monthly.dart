import 'dart:async';
import 'dart:math';
import 'package:bom_front/model/statistic_model.dart';
import 'package:bom_front/repository/statistic_repo.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartMonthly extends StatefulWidget {
  const BarChartMonthly({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartMonthlyState();
}

class BarChartMonthlyState extends State<BarChartMonthly> {
  final Color barBackgroundColor = const Color.fromRGBO(40, 35, 75, 0.1);
  Statistic statistic_data = new Statistic();

  int touchedIndex = -1;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xffffffff),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Text(
                    '2022년 3월 1주차',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(mainBarData()),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.amberAccent,
    double width = 10,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(30, (i) {
        /*여기에 time 넣어야함 */
        switch (i) {
          case 0:
            return makeGroupData(0, 10, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(7, 10, isTouched: i == touchedIndex);
          case 8:
            return makeGroupData(8, 6.5, isTouched: i == touchedIndex);
          case 9:
            return makeGroupData(9, 5, isTouched: i == touchedIndex);
          case 10:
            return makeGroupData(10, 7.5, isTouched: i == touchedIndex);
          case 11:
            return makeGroupData(11, 9, isTouched: i == touchedIndex);
          case 12:
            return makeGroupData(12, 11.5, isTouched: i == touchedIndex);
          case 13:
            return makeGroupData(13, 6.5, isTouched: i == touchedIndex);
          case 14:
            return makeGroupData(14, 10, isTouched: i == touchedIndex);
          case 15:
            return makeGroupData(15, 6.5, isTouched: i == touchedIndex);
          case 16:
            return makeGroupData(16, 5, isTouched: i == touchedIndex);
          case 17:
            return makeGroupData(17, 7.5, isTouched: i == touchedIndex);
          case 18:
            return makeGroupData(18, 9, isTouched: i == touchedIndex);
          case 19:
            return makeGroupData(19, 11.5, isTouched: i == touchedIndex);
          case 20:
            return makeGroupData(20, 6.5, isTouched: i == touchedIndex);
          case 21:
            return makeGroupData(21, 10, isTouched: i == touchedIndex);
          case 22:
            return makeGroupData(22, 6.5, isTouched: i == touchedIndex);
          case 23:
            return makeGroupData(23, 5, isTouched: i == touchedIndex);
          case 24:
            return makeGroupData(24, 7.5, isTouched: i == touchedIndex);
          case 25:
            return makeGroupData(25, 9, isTouched: i == touchedIndex);
          case 26:
            return makeGroupData(26, 11.5, isTouched: i == touchedIndex);
          case 27:
            return makeGroupData(27, 6.5, isTouched: i == touchedIndex);
          case 28:
            return makeGroupData(28, 6.5, isTouched: i == touchedIndex);
          case 29:
            return makeGroupData(29, 6.5, isTouched: i == touchedIndex);
          case 30:
            return makeGroupData(30, 6.5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              int num = 0;
              while (true) {
                if (num == group.x.toInt()) {
                  weekDay = '3/${num + 1}';
                  break;
                }
                num++;
              }

              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 7:
        text = const Text('3.7', style: style);
        break;
      case 14:
        text = const Text('3.14', style: style);
        break;
      case 21:
        text = const Text('3.21', style: style);
        break;
      case 28:
        text = const Text('3.28', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return Padding(padding: const EdgeInsets.only(top: 16), child: text);
  }
}

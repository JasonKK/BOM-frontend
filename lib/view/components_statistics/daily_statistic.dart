import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DailyChart extends StatelessWidget {
  Map<String, double> dataMap = {
    "국어": 5,
    "수학": 3,
    "사회": 2,
    "과학": 2,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: PieChart(
          chartType: ChartType.ring,
          ringStrokeWidth: 10,
          dataMap: dataMap,
          centerText: "6시간 20분",
          centerTextStyle: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
          chartRadius: MediaQuery.of(context).size.width / 1.7,
          legendOptions: LegendOptions(
              legendPosition: LegendPosition.bottom,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle()),
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
            showChartValueBackground: false,
            showChartValues: false, // 값안보이게 하기
          ),
        ),
      ),
    );
  }
}

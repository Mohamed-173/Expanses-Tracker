// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expanses_tracker/pages/home/widget/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  double? maxY;
  double satAmount;
  double sunAmount;
  double monAmount;
  double tueAmount;
  double wedAmount;
  double thuAmount;
  double friAmount;

  MyBarGraph({
    Key? key,
    required this.maxY,
    required this.satAmount,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      satAmount: satAmount,
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thuAmount: thuAmount,
      friAmount: friAmount,
    );
    myBarData.initializeBarData();
    print(myBarData.barData.length);
    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        barGroups: myBarData.barData
            .map(
              (element) => BarChartGroupData(
                x: element.x,
                barRods: [
                  BarChartRodData(
                    toY: element.y,
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

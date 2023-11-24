// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expanses_tracker/pages/home/widget/bar_graph/bar_data.dart';
import 'package:expanses_tracker/utils/constant/colors.dart';
import 'package:expanses_tracker/utils/widgets/custom_text_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getButtomTitle,
            ),
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData
            .map(
              (element) => BarChartGroupData(
                x: element.x,
                barRods: [
                  BarChartRodData(
                    color: AppColors.primaryElement,
                    width: 15.w,
                    borderRadius: BorderRadius.circular(5.r),
                    toY: element.y,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      color: AppColors.primaryFourElementText,
                      toY: maxY,
                    ),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget getButtomTitle(double value, TitleMeta meta) {
    switch (value.toInt()) {
      case 0:
        return CustomTextWidget(text: "Sat");
      case 1:
        return CustomTextWidget(text: "Sun");
      case 2:
        return CustomTextWidget(text: "Mon");
      case 3:
        return CustomTextWidget(text: "Tue");
      case 4:
        return CustomTextWidget(text: "Wed");
      case 5:
        return CustomTextWidget(text: "The");
      case 6:
        return CustomTextWidget(text: "Fri");

      default:
        return CustomTextWidget(text: "N");
    }
  }
}

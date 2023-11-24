// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expanses_tracker/data/storage_service.dart';
import 'package:expanses_tracker/pages/home/widget/bar_graph/bar_data.dart';
import 'package:expanses_tracker/pages/home/widget/bar_graph/bar_graph.dart';
import 'package:expanses_tracker/utils/widgets/custom_text_widget.dart';
import 'package:expanses_tracker/utils/widgets/date_time_helper.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    Key? key,
    required this.startOfWeek,
  }) : super(key: key);

  double readjustSize(
    StorageServices value,
    String saturday,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpanseSummury()[saturday] ?? 0,
      value.calculateDailyExpanseSummury()[sunday] ?? 0,
      value.calculateDailyExpanseSummury()[monday] ?? 0,
      value.calculateDailyExpanseSummury()[tuesday] ?? 0,
      value.calculateDailyExpanseSummury()[wednesday] ?? 0,
      value.calculateDailyExpanseSummury()[tuesday] ?? 0,
      value.calculateDailyExpanseSummury()[friday] ?? 0,
    ];

    values.sort();
    max = values.last * 1;
    return max == 0 ? 100 : max;
  }

  double weekTotalAmount(
    StorageServices value,
    String saturday,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
  ) {
    double totalAmount = 0;

    List<double> values = [
      value.calculateDailyExpanseSummury()[saturday] ?? 0,
      value.calculateDailyExpanseSummury()[sunday] ?? 0,
      value.calculateDailyExpanseSummury()[monday] ?? 0,
      value.calculateDailyExpanseSummury()[tuesday] ?? 0,
      value.calculateDailyExpanseSummury()[wednesday] ?? 0,
      value.calculateDailyExpanseSummury()[tuesday] ?? 0,
      value.calculateDailyExpanseSummury()[friday] ?? 0,
    ];

    for (var i = 0; i < values.length; i++) {
      totalAmount += values[i];
    }
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<StorageServices>(
      builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.h),
              child: Row(
                children: [
                  const CustomTextWidget(text: "Week Total: "),
                  CustomTextWidget(
                      text: "\$${weekTotalAmount(
                    value,
                    saturday,
                    sunday,
                    monday,
                    tuesday,
                    wednesday,
                    thursday,
                    friday,
                  )}")
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              height: 200.h,
              child: MyBarGraph(
                maxY: readjustSize(
                  value,
                  saturday,
                  sunday,
                  monday,
                  tuesday,
                  wednesday,
                  thursday,
                  friday,
                ),
                satAmount: value.calculateDailyExpanseSummury()[saturday] ?? 0,
                sunAmount: value.calculateDailyExpanseSummury()[sunday] ?? 0,
                monAmount: value.calculateDailyExpanseSummury()[monday] ?? 0,
                tueAmount: value.calculateDailyExpanseSummury()[tuesday] ?? 0,
                wedAmount: value.calculateDailyExpanseSummury()[wednesday] ?? 0,
                thuAmount: value.calculateDailyExpanseSummury()[thursday] ?? 0,
                friAmount: value.calculateDailyExpanseSummury()[friday] ?? 0,
              ),
            ),
          ],
        );
      },
    );
  }
}

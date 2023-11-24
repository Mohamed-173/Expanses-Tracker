// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expanses_tracker/data/storage_service.dart';
import 'package:expanses_tracker/pages/home/widget/bar_graph/bar_data.dart';
import 'package:expanses_tracker/pages/home/widget/bar_graph/bar_graph.dart';
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

  @override
  Widget build(BuildContext context) {
    String saturday =
        convertDateTimeToString(startOfWeek.add(Duration(days: 0)));
    String sunday = convertDateTimeToString(startOfWeek.add(Duration(days: 1)));
    String monday = convertDateTimeToString(startOfWeek.add(Duration(days: 2)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(Duration(days: 3)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(Duration(days: 4)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(Duration(days: 5)));
    String friday = convertDateTimeToString(startOfWeek.add(Duration(days: 6)));

    return Consumer<StorageServices>(builder: (context, value, child) {
      return Container(
        margin: EdgeInsets.only(top: 5.h),
        height: 200.h,
        child: MyBarGraph(
          maxY: 100,
          satAmount: value.calculateDailyExpanseSummury()[saturday] ?? 0,
          sunAmount: value.calculateDailyExpanseSummury()[sunday] ?? 0,
          monAmount: value.calculateDailyExpanseSummury()[monday] ?? 0,
          tueAmount: value.calculateDailyExpanseSummury()[tuesday] ?? 0,
          wedAmount: value.calculateDailyExpanseSummury()[wednesday] ?? 0,
          thuAmount: value.calculateDailyExpanseSummury()[thursday] ?? 0,
          friAmount: value.calculateDailyExpanseSummury()[friday] ?? 0,
        ),
      );
    });
  }
}

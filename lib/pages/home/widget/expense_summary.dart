// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expanses_tracker/pages/home/widget/bar_graph/bar_graph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    Key? key,
    required this.startOfWeek,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      height: 200.h,
      child: MyBarGraph(
        maxY: 200,
        satAmount: 45,
        sunAmount: 66,
        monAmount: 77,
        tueAmount: 11,
        wedAmount: 20,
        thuAmount: 90,
        friAmount: 10,
      ),
    );
  }
}

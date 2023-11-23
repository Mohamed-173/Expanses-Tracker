import 'package:expanses_tracker/utils/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String tag;
  final String amount;
  final DateTime dateTime;

  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text("${dateTime.day}/${dateTime.month}/${dateTime.year}"),
      trailing: Column(
        children: [
          CustomTextWidget(
            text: "\$$amount",
            fontSize: 15.h,
            fontWeight: FontWeight.bold,
          ),
          Text(tag),
        ],
      ),
    );
    ;
  }
}

import 'package:expanses_tracker/utils/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String tag;
  final String amount;
  final DateTime dateTime;
  final Function(BuildContext context) deleteTab;
  final Function(BuildContext context) updateTab;

  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.tag,
    required this.deleteTab,
    required this.updateTab,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            onPressed: deleteTab,
            icon: Icons.delete,
          ),
          SlidableAction(
            backgroundColor: Colors.grey,
            onPressed: updateTab,
            icon: Icons.update,
          ),
        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(
            "${dateTime.hour}h:${dateTime.minute}m  ${dateTime.day}/${dateTime.month}/${dateTime.year}"),
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
      ),
    );
    ;
  }
}

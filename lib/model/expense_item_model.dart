// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExpenseItem {
  final String name;
  final String tag;
  final DateTime dateTime;
  final String amount;

  ExpenseItem(
      {required this.name,
      required this.tag,
      required this.dateTime,
      required this.amount});

  ExpenseItem copyWith({
    String? name,
    String? tag,
    DateTime? dateTime,
    String? amount,
  }) {
    return ExpenseItem(
      name: name ?? this.name,
      tag: tag ?? this.tag,
      dateTime: dateTime ?? this.dateTime,
      amount: amount ?? this.amount,
    );
  }
}

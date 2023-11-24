import 'package:expanses_tracker/data/hive_database.dart';
import 'package:expanses_tracker/model/expense_item_model.dart';
import 'package:expanses_tracker/utils/widgets/date_time_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class StorageServices extends ChangeNotifier {
// using shared prefernce for store data and get and just like local api

// list of all data
  final List<ExpenseItem> _listAllExpenseItems = [];
  List<ExpenseItem> get listAllExpenseItems => _listAllExpenseItems;

  // get all data
  List<ExpenseItem> getAllItems() {
    return listAllExpenseItems;
  }

  final db = HiveDatabase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      listAllExpenseItems.addAll(db.readData());
    }
  }

  // save data

  void saveItems(ExpenseItem expenseItem) {
    listAllExpenseItems.add(expenseItem);
    notifyListeners();
    db.saveData(listAllExpenseItems);
  }

  // update data
  void deleteItem(
    ExpenseItem expenseItem,
  ) {
    listAllExpenseItems.remove(expenseItem);
    notifyListeners();
    db.saveData(listAllExpenseItems);
  }

  //delete data
  String getDateName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return '';
    }
  }

  // startOfWeekDay
  DateTime startOfWeekDay() {
    DateTime? startOfWeekDay;

    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getDateName(today.subtract(Duration(days: i))) == "Sat") {
        startOfWeekDay = today.subtract(Duration(days: i));
      }
    }
    return startOfWeekDay!;
  }

  Map<String, double> calculateDailyExpanseSummury() {
    Map<String, double> dailyExpanseSummury = {};

    for (var item in listAllExpenseItems) {
      String date = convertDateTimeToString(item.dateTime);
      double amount = double.parse(item.amount);

      if (dailyExpanseSummury.containsKey(date)) {
        double currentAmount = dailyExpanseSummury[date]!;
        currentAmount += amount;
        dailyExpanseSummury[date] = currentAmount;
      } else {
        dailyExpanseSummury.addAll({date: amount});
      }
    }
    return dailyExpanseSummury;
  }
}

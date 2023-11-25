import 'dart:developer';

import 'package:expanses_tracker/data/hive_database.dart';
import 'package:expanses_tracker/model/expense_item_model.dart';
import 'package:expanses_tracker/utils/widgets/date_time_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class StorageServices extends ChangeNotifier {
// using shared prefernce for store data and get and just like local api

// list of all data
  List<ExpenseItem> listAllExpenseItems = [];
  DateTime dateTimePickar = DateTime.now();
  DateTime dtpk = DateTime.now();

  void checkDateTimeTemp({DateTime? dateTimeNow}) {
    if (dateTimeNow == null) {
      return;
    }
    if (dateTimePickar != dateTimeNow) {
      dateTimePickar = dateTimeNow;
    }

    // notifyListeners();
  }

  void saveDateTimeTemp(DateTime dateTime) {
    dateTimePickar = dateTime;
    notifyListeners();
  }

  // get all data
  List<ExpenseItem> getAllItems() {
    return listAllExpenseItems;
  }

  void sortByDate() {
    for (var i = 0; i < listAllExpenseItems.length; i++) {
      listAllExpenseItems.sort(
        (a, b) {
          var adata = a.dateTime;
          var bdata = b.dateTime;
          return adata.compareTo(bdata);
        },
      );
    }
  }

  final db = HiveDatabase();
  Future<void> prepareData() async {
    if (db.readData().isNotEmpty) {
      listAllExpenseItems.addAll(db.readData());
      try {
        sortByDate();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  // void clear() {
  //   db.clear();
  // }

  // save data

  void saveItems(ExpenseItem expenseItem) {
    listAllExpenseItems.add(expenseItem);
    try {
      sortByDate();
    } catch (e) {
      log(e.toString());
    }
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

  void updateItem(ExpenseItem expenseItem, int index) {
    try {
      listAllExpenseItems[0] = expenseItem;

      db.saveData(listAllExpenseItems);

      sortByDate();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
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
      // String date = item.dateTime;
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

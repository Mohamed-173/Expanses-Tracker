import 'package:hive_flutter/hive_flutter.dart';

import '../model/expense_item_model.dart';

class HiveDatabase {
  // getting database for accessing it
  final _myBox = Hive.box("expense_database");
  void clear() {
    _myBox.clear();
  }

  // read database

  void saveData(List<ExpenseItem> allItems) {
    List<List<dynamic>> allExpenseFormated = [];
//store our data to string and datatime type
    for (var expense in allItems) {
      List<dynamic> expenseFormated = [
        expense.name,
        expense.tag,
        expense.amount,
        expense.dateTime,
      ];
      allExpenseFormated.add(expenseFormated);
    }

// save data to local storage by formatted
    _myBox.put("ALL_EXPENSES", allExpenseFormated);
  }

  // write database
  List<ExpenseItem> readData() {
    //getting data

// if we dont have data then we return empty list
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> listExpense = [];
    for (var i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String tag = savedExpenses[i][1];
      String amount = savedExpenses[i][2];
      DateTime dateTime = savedExpenses[i][3];

      ExpenseItem expenseItem = ExpenseItem(
        name: name,
        tag: tag,
        dateTime: dateTime,
        amount: amount,
      );
      listExpense.add(expenseItem);
    }
    return listExpense;
  }
}

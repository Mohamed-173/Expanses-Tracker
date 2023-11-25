import 'package:expanses_tracker/data/storage_service.dart';
import 'package:expanses_tracker/model/expense_item_model.dart';
import 'package:expanses_tracker/pages/home/widget/bar_graph/bar_data.dart';

import 'package:expanses_tracker/pages/home/widget/expense_summary.dart';
import 'package:expanses_tracker/pages/home/widget/home_page_widgets.dart';
import 'package:expanses_tracker/utils/constant/colors.dart';
import 'package:expanses_tracker/pages/home/widget/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  TextEditingController name = TextEditingController();

  TextEditingController tag = TextEditingController();
  TextEditingController amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<StorageServices>(context, listen: false).prepareData();
    super.initState();
  }

  void showAlertDialog(TypeAlert typeAlert,
      {int? index, ExpenseItem? expenseItem}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Extense"),
          content: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value == null || value == '') {
                        return "Name Field not Be Empty";
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter Name",
                    ),
                  ),
                  TextFormField(
                    controller: tag,
                    validator: (value) {
                      if (value == null || value == '') {
                        return "Tag Field not Be Empty";
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter Tag",
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      {
                        if (value == null || value == '') {
                          return "Amount Field not Be Empty";
                        }

                        RegExp regex = RegExp(
                            r'^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,4})?$');
                        if (!regex.hasMatch(value)) {
                          return 'Enter Valid Number';
                        } else {
                          return null;
                        }
                      }
                    },
                    controller: amount,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                    ],
                    decoration: const InputDecoration(
                      hintText: "Enter Number",
                    ),
                  ),
                  // TextFormField(
                  //   controller: date,
                  // ),
                ],
              ),
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: typeAlert == TypeAlert.add
                  ? save
                  : () {
                      update(
                          ExpenseItem(
                            name: name.text,
                            tag: tag.text,
                            dateTime: DateTime.now(),
                            amount: amount.text,
                          ),
                          index!);
                      Navigator.of(context).pop();
                      clear();
                    },
              child: Text(typeAlert == TypeAlert.add ? "save" : "update"),
            ),
            MaterialButton(
              onPressed: cancel,
              child: const Text("cancel"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackground,
      child: Consumer<StorageServices>(builder: (context, value, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.primaryBackground,
            appBar: homePageAppbar(),
            body: Container(
              child: Center(
                child: ListView(
                  children: [
                    ExpenseSummary(
                        startOfWeek: StorageServices().startOfWeekDay()),
                    SizedBox(
                      height: 20.h,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: value.getAllItems().length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: AppColors.primaryBackground,
                          child: ExpenseTile(
                            name: value.getAllItems()[index].name,
                            amount: value.getAllItems()[index].amount,
                            dateTime: value.getAllItems()[index].dateTime,
                            tag: value.getAllItems()[index].tag,
                            deleteTab: (context) {
                              delete(value.getAllItems()[index]);
                            },
                            updateTab: (context) {
                              name.text = value.listAllExpenseItems[index].name;
                              tag.text = value.listAllExpenseItems[index].tag;
                              amount.text =
                                  value.listAllExpenseItems[index].amount;
                              // showing update alert dialog
                              showAlertDialog(
                                TypeAlert.update,
                                expenseItem: value.listAllExpenseItems[index],
                                index: index,
                              );
                              update(
                                  ExpenseItem(
                                      name: name.text,
                                      tag: tag.text,
                                      dateTime: DateTime.now(),
                                      amount: amount.text),
                                  index);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showAlertDialog(TypeAlert.add);
              },
              child: const Icon(
                Icons.add,
                color: AppColors.primaryElementText,
              ),
            ),
          ),
        );
      }),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
    } else {
      return;
    }

    Provider.of<StorageServices>(context, listen: false).saveItems(ExpenseItem(
      name: name.text,
      tag: tag.text,
      dateTime: DateTime.now(),
      amount: amount.text,
    ));

    Navigator.of(context).pop();
    clear();
  }

  void delete(
    ExpenseItem expenseItem,
  ) {
    Provider.of<StorageServices>(context, listen: false)
        .deleteItem(expenseItem);
  }

  void update(ExpenseItem expenseItem, int index) {
    print(index);
    Provider.of<StorageServices>(context, listen: false)
        .updateItem(expenseItem, index);
  }

  void clear() {
    name.clear();
    tag.clear();

    amount.clear();
  }

  void cancel() {
    Navigator.of(context).pop();
    clear();
  }
}

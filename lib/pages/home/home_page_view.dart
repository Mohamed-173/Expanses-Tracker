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

  void addNewExpense() {
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
                    decoration: const InputDecoration(
                      hintText: "Enter Name",
                    ),
                  ),
                  TextFormField(
                    controller: tag,
                    decoration: const InputDecoration(
                      hintText: "Enter Tag",
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      {
                        RegExp regex = RegExp(
                            r'^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,4})?$');
                        if (!regex.hasMatch(value!)) {
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
              onPressed: save,
              child: const Text("save"),
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
                        return ExpenseTile(
                          name: value.getAllItems()[index].name,
                          amount: value.getAllItems()[index].amount,
                          dateTime: DateTime.now(),
                          tag: value.getAllItems()[index].tag,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: addNewExpense,
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

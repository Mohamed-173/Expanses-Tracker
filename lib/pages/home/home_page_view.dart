import 'package:expanses_tracker/data/storage_service.dart';
import 'package:expanses_tracker/model/expense_item_model.dart';
import 'package:expanses_tracker/pages/home/bloc/home_page_bloc.dart';
import 'package:expanses_tracker/pages/home/bloc/home_page_event.dart';
import 'package:expanses_tracker/pages/home/bloc/home_page_state.dart';
import 'package:expanses_tracker/pages/home/widget/expense_summary.dart';
import 'package:expanses_tracker/pages/home/widget/home_page_widgets.dart';
import 'package:expanses_tracker/utils/constant/colors.dart';
import 'package:expanses_tracker/pages/home/widget/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  TextEditingController name = TextEditingController();

  TextEditingController tag = TextEditingController();
  TextEditingController amount = TextEditingController();

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Extense"),
          content: Container(
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: name,
                  ),
                  TextFormField(
                    controller: tag,
                  ),
                  TextFormField(
                    controller: amount,
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
    return SafeArea(
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.primaryBackground,
            appBar: homePageAppbar(),
            body: Container(
              child: Center(
                child: ListView(
                  children: [
                    ExpenseSummary(
                        startOfWeek: StorageServices().startOfWeekDay()),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.allItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExpenseTile(
                          name: state.allItems[index].name,
                          amount: state.allItems[index].amount,
                          dateTime: state.allItems[index].dateTime,
                          tag: state.allItems[index].tag,
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
          );
        },
      ),
    );
  }

  void save() {
    BlocProvider.of<HomePageBloc>(context).add(
      AddItems(
        expenseItem: ExpenseItem(
          name: name.value.text,
          tag: tag.value.text,
          dateTime: DateTime.now(),
          amount: amount.value.text,
        ),
      ),
    );

    Navigator.of(context).pop();
    name.clear();
    tag.clear();

    amount.clear();
  }

  void cancel() {
    Navigator.of(context).pop();
  }
}

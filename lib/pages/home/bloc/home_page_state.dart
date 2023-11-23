// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:expanses_tracker/model/expense_item_model.dart';

class HomePageState extends Equatable {
  final List<ExpenseItem> allItems;
  const HomePageState({
    this.allItems = const [],
  });
  HomePageState copyWith({List<ExpenseItem>? allItems}) {
    return HomePageState(
      allItems: allItems ?? this.allItems,
    );
  }

  @override
  List<Object?> get props => [allItems];
}

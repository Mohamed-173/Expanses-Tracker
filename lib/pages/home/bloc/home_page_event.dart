import 'package:equatable/equatable.dart';
import 'package:expanses_tracker/model/expense_item_model.dart';

class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object?> get props => [];
}

class AddItems extends HomePageEvent {
  final ExpenseItem expenseItem;

  const AddItems({required this.expenseItem});
  @override
  List<Object?> get props => [expenseItem];
}

class DeleteItem extends HomePageEvent {
  final ExpenseItem expenseItem;

  const DeleteItem({required this.expenseItem});
  @override
  List<Object?> get props => [expenseItem];
}

class UpdateItem extends HomePageEvent {
  final ExpenseItem expenseItem;

  const UpdateItem({required this.expenseItem});
  @override
  List<Object?> get props => [expenseItem];
}

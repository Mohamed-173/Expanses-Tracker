import 'package:expanses_tracker/pages/home/bloc/home_page_event.dart';
import 'package:expanses_tracker/pages/home/bloc/home_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(const HomePageState()) {
    on<AddItems>(_addItem);
    on<UpdateItem>(_updateItem);
    on<DeleteItem>(_deleteItem);
  }
  void _addItem(AddItems event, Emitter<HomePageState> emit) {
    emit(HomePageState().copyWith(
      allItems: List.from(state.allItems)..add(event.expenseItem),
    ));
  }

  void _updateItem(UpdateItem event, Emitter<HomePageState> emit) {
    // emit(HomePageState().copyWith(
    //   allItems: List.from(state.allItems)..add(event.expenseItem),
    // ));
  }

  void _deleteItem(DeleteItem event, Emitter<HomePageState> emit) {
    // emit(HomePageState().copyWith(
    //   allItems: List.from(state.allItems)..add(event.expenseItem),
    // ));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleListCubit extends Cubit<List<String>> {
  SimpleListCubit(super.initialState);

  void addItem(item) {
    List<String> newList = List.from(state)..add(item);

    emit(newList);
  }

  void removeItem(index) {
    List<String> newList = List.from(state)..removeAt(index);

    emit(newList);
  }
}

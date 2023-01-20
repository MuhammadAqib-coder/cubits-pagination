import 'package:flutter_bloc/flutter_bloc.dart';

class BoxCubit extends Cubit<List<bool>> {
  BoxCubit(super.initialState);

  void boxStateChange(item, index) {
    List<bool> newList;

    newList = List.from(state);
    newList[index] = item;

    emit(newList);
  }

  void addBox(item) {
    List<bool> newList = List.from(state)..add(item);

    emit(newList);
  }

  void removeBox(index) {
    List<bool> newList = List.from(state)..removeAt(index);

    emit(newList);
  }
}

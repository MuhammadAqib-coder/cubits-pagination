import 'package:flutter_bloc/flutter_bloc.dart';

class TrueBoxCubit extends Cubit<List<bool>> {
  TrueBoxCubit() : super([]);

  void addBox(item) {
    List<bool> newList = List.from(state)..add(item);

    emit(newList);
  }

  void removeBox(index) {
    List<bool> newList = List.from(state)..removeAt(index);

    emit(newList);
  }
}

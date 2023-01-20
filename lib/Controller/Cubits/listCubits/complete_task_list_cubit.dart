import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteTaskListCubit extends Cubit<List<String>> {
  CompleteTaskListCubit() : super([]);

  void addTask(item) {
    List<String> newList = List.from(state)..add(item);

    emit(newList);
  }

  void removeTask(index) {
    List<String> newList = List.from(state)..removeAt(index);

    emit(newList);
  }
}

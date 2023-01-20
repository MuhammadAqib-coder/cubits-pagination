import 'package:flutter_bloc/flutter_bloc.dart';

class NewTaskListCubit extends Cubit<List<String>> {
  NewTaskListCubit() : super([]);

  void addTask(item) {
    List<String> newList = List.from(state)..add(item);

    emit(newList);
  }

  void removeTask(index) {
    List<String> newList = List.from(state)..removeAt(index);

    emit(newList);
  }
}

import 'package:cubit_task/Controller/Cubits/UserDataCubit/user_state.dart';
import 'package:cubit_task/Controller/Repositories/user_repo.dart';
import 'package:cubit_task/Utils/status_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserCubitInitial());

  fetchUsers() async {
    try {
      emit(UserCubitLoading());
      // UserModel? userModel =
      int response = await UserRepo.getAllUser();
      if (response == 200) {
        emit(UserCubitLoaded());
        // return userModel;
      } else if (response == StatusCode.socketException) {
        emit(UserSocketException());
      } else if (response == StatusCode.tokenExpire) {
        emit(TokenExpire());
      } else {
        emit(GeneralException());
      }
    } catch (e) {
      emit(GeneralException());
    }
  }
}

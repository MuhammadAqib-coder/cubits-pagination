import 'package:cubit_task/Controller/Cubits/UserLoginCubit/user_login_state.dart';
import 'package:cubit_task/Controller/Repositories/user_login_repo.dart';
import 'package:cubit_task/Utils/status_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(UserLoginInitial());

  loginUser({required email, required password}) async {
    try {
      emit(UserLoginLoading());
      int response =
          await UserLoginRepo.userLogin(email: email, password: password);
      if (response == 200) {
        emit(UserLoginLoaded());
      } else if (response == 400) {
        emit(UserLoginBadRequest());
      } else if (response == StatusCode.socketException) {
        emit(UserLoginSocketException());
      } else if (response == StatusCode.tokenExpire) {
        emit(UserLoginTokenExpire());
      } else {
        emit(UserLoginWrongEmailPassword());
      }
    } catch (e) {
      emit(UserLoginException());
    }
  }
}

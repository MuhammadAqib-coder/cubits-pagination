import 'package:cubit_task/Controller/Cubits/UserRegisterCubit/user_register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Utils/status_code.dart';
import '../../Repositories/user_login_repo.dart';

class UserRegisterCubit extends Cubit<UserRegisterState> {
  UserRegisterCubit() : super(UserRegisterInitial());

  registerUser({required email, required password}) async {
    try {
      emit(UserRegisterLoading());
      int response =
          await UserLoginRepo.userRegister(email: email, password: password);
      if (response == 200) {
        emit(UserRegisterLoaded());
      } else if (response == 400) {
        emit(UserRegisterBadRequest());
      } else if (response == StatusCode.socketException) {
        emit(UserRegisterSocketException());
      } else if (response == StatusCode.tokenExpire) {
        emit(UserRegisterTokenExpire());
      } else {
        emit(UserRegisterWrongEmailPassword());
      }
    } catch (e) {
      emit(UserRegisterException());
    }
  }
}

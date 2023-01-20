abstract class UserRegisterState {}

class UserRegisterLoading extends UserRegisterState {}

class UserRegisterLoaded extends UserRegisterState {}

class UserRegisterInitial extends UserRegisterState {}

class UserRegisterException extends UserRegisterState {}

class UserRegisterSocketException extends UserRegisterState {}

class UserRegisterTokenExpire extends UserRegisterState {}

class UserRegisterWrongEmailPassword extends UserRegisterState {}

class UserRegisterBadRequest extends UserRegisterState {}

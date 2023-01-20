abstract class UserLoginState {}

class UserLoginLoading extends UserLoginState {}

class UserLoginLoaded extends UserLoginState {}

class UserLoginInitial extends UserLoginState {}

class UserLoginException extends UserLoginState {}

class UserLoginSocketException extends UserLoginState {}

class UserLoginTokenExpire extends UserLoginState {}

class UserLoginWrongEmailPassword extends UserLoginState {}

class UserLoginBadRequest extends UserLoginState {}

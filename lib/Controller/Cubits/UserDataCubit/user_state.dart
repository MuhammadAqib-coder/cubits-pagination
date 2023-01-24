import 'package:cubit_task/Models/User/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

@immutable
abstract class UserState {}

class UserCubitInitial extends UserState {}

class TimeOut extends UserState {}

class UserCubitLoading extends UserState {}

class UserCubitLoaded extends UserState {
  // UserModel userModel;
  UserCubitLoaded();
}

class UserSocketException extends UserState {}

class TokenExpire extends UserState {}

class GeneralException extends UserState {}

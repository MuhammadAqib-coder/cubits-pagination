import 'package:cubit_task/Controller/Cubits/UserRegisterCubit/user_register_cubit.dart';
import 'package:cubit_task/Controller/Cubits/pageCubit/page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Cubits/UserDataCubit/user_cubit.dart';
import '../Controller/Cubits/UserLoginCubit/user_login_cubit.dart';
import '../Controller/Cubits/boolCubits/box_cubit.dart';
import '../Controller/Cubits/boolCubits/true_box_cubit.dart';
import '../Controller/Cubits/listCubits/complete_task_list_cubit.dart';
import '../Controller/Cubits/listCubits/new_list_task_cubit.dart';
import '../Controller/Cubits/listCubits/simple_list_cubit.dart';

showSnackBar(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

dynamic cubits = [
  BlocProvider(lazy: false, create: (_) => SimpleListCubit([])),
  BlocProvider(lazy: false, create: (_) => CompleteTaskListCubit()),
  BlocProvider(create: (_) => NewTaskListCubit()),
  BlocProvider(lazy: false, create: (_) => BoxCubit([])),
  BlocProvider(lazy: false, create: (_) => TrueBoxCubit()),
  BlocProvider(create: (_) => UserCubit()),
  BlocProvider(create: (_) => UserLoginCubit()),
  BlocProvider(create: (_) => UserRegisterCubit()),
  BlocProvider(create: (_) => PageCubit()),
];

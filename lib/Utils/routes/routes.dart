import 'package:cubit_task/Utils/routes/routes_name.dart';
import 'package:cubit_task/view/add_task_view.dart';
import 'package:cubit_task/view/complete_task_view.dart';
import 'package:cubit_task/view/users.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.secondExample:
        return MaterialPageRoute(builder: (_) => const AddTaskView());
      case RoutesName.completeTask:
        return MaterialPageRoute(builder: (_) => const CompleteTaskView());

      case RoutesName.userView:
        return MaterialPageRoute(builder: (_) => const UsersView());
      default:
        return MaterialPageRoute(builder: (_) => const AddTaskView());
    }
  }
}

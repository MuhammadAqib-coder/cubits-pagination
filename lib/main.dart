import 'package:cubit_task/Utils/routes/routes.dart';
import 'package:cubit_task/Utils/utils.dart';
import 'package:cubit_task/view/posts_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: cubits,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc State Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //for simple cubit use ItemAddDelView() widget
        //for api integration with cubit state use LoginView() widget
        //for pagination with api use PostView() widget
        home: const PostView(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

import 'package:cubit_task/Utils/routes/routes.dart';
import 'package:cubit_task/Utils/utils.dart';
import 'package:cubit_task/view/item_add_del_view.dart';
import 'package:cubit_task/view/login_in_view.dart';
import 'package:cubit_task/view/posts_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      path: "assets/translations",
      supportedLocales: const [Locale('en'), Locale('ur')],
      startLocale: const Locale('en'),
      saveLocale: false,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: cubits,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Bloc State Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //for simple cubit use ItemAddDelView() widget
        //for api integration with cubit state use LoginView() widget
        //for pagination with api use PostView() widget
        home: LoginView(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

import 'package:cubit_task/Controller/Cubits/UserLoginCubit/user_login_cubit.dart';
import 'package:cubit_task/Controller/Cubits/UserLoginCubit/user_login_state.dart';
import 'package:cubit_task/Models/DataController/user_controler.dart';
import 'package:cubit_task/Utils/routes/routes_name.dart';
import 'package:cubit_task/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Cubits/UserRegisterCubit/user_register_cubit.dart';
import '../Controller/Cubits/UserRegisterCubit/user_register_state.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  var _emailControler = TextEditingController();
  var _passControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login State'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailControler,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            50 * MediaQuery.of(context).size.height / 740))),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 10 * MediaQuery.of(context).size.height / 740),
              TextField(
                controller: _passControler,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          50 * MediaQuery.of(context).size.height / 740)),
                  // suffixIcon: IconButton(
                  //     icon: isPasswordVisible
                  //         ? const Icon(Icons.visibility)
                  //         : const Icon(Icons.visibility_off),
                  //     onPressed: () => setState(() {
                  //           isPasswordVisible = !isPasswordVisible;
                  //         }))
                ),
                keyboardType: TextInputType.emailAddress,
                // obscureText: !isPasswordVisible,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF5372DD)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  const BorderSide(color: Color(0xFF6F99F7))))),
                  onPressed: () async {
                    if (_emailControler.text.isNotEmpty &&
                        _passControler.text.isNotEmpty) {
                      await context.read<UserLoginCubit>().loginUser(
                          email: _emailControler.text.trim(),
                          password: _passControler.text.trim());
                      _emailControler.clear();
                      _passControler.clear();
                    } else {
                      showSnackBar(context, 'enter email or password');
                    }
                  },
                  child: BlocConsumer<UserLoginCubit, UserLoginState>(
                    listener: (context, loginState) {
                      if (loginState is UserLoginLoaded) {
                        if (UserControler.userLoginCredential != null &&
                            UserControler.userRegisterCredential != null) {
                          if (UserControler.userLoginCredential['token'] ==
                              UserControler.userRegisterCredential['token']) {
                            Navigator.pushNamed(context, RoutesName.userView);
                          }
                        } else {
                          showSnackBar(context, 'no user registered');
                        }
                      }
                      if (loginState is UserLoginSocketException) {
                        showSnackBar(context, 'No Internet');
                      }

                      if (loginState is UserLoginBadRequest) {
                        showSnackBar(context, 'wrong password or email');
                      }
                    },
                    builder: (context, loginState) {
                      return SizedBox(
                          width: 150,
                          height: 30,
                          child: Center(
                            child: (loginState is UserLoginLoading)
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 4.0,
                                  )
                                : const Text('Login',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                          ));
                    },
                  )),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF5372DD)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  const BorderSide(color: Color(0xFF6F99F7))))),
                  onPressed: () async {
                    if (_emailControler.text.isNotEmpty &&
                        _passControler.text.isNotEmpty) {
                      await context.read<UserRegisterCubit>().registerUser(
                          email: _emailControler.text.trim(),
                          password: _passControler.text.trim());
                      _emailControler.clear();
                      _passControler.clear();
                    } else {
                      showSnackBar(context, 'enter email or password');
                    }
                  },
                  child: BlocConsumer<UserRegisterCubit, UserRegisterState>(
                    listener: (context, registerState) {
                      if (registerState is UserRegisterLoaded) {
                        showSnackBar(context, 'user added successfully');
                      }
                      if (registerState is UserRegisterSocketException) {
                        showSnackBar(context, 'No Internet');
                      }
                      if (registerState is UserLoginBadRequest) {
                        showSnackBar(context, 'wrong password or email');
                      }
                    },
                    builder: (context, registerState) {
                      return SizedBox(
                          width: 150,
                          height: 30,
                          child: Center(
                            child: (registerState is UserRegisterLoading)
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 4.0,
                                  )
                                : const Text('Register',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                          ));
                    },
                  ))
            ],
          )),
    );
  }
}

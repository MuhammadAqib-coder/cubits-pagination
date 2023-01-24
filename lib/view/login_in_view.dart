import 'package:cubit_task/Const/const_data.dart';
import 'package:cubit_task/Controller/Cubits/UserLoginCubit/user_login_cubit.dart';
import 'package:cubit_task/Controller/Cubits/UserLoginCubit/user_login_state.dart';
import 'package:cubit_task/Models/DataController/user_controler.dart';
import 'package:cubit_task/Utils/routes/routes_name.dart';
import 'package:cubit_task/Utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Cubits/StringCubit/language_cubit.dart';
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
        title: const Text('login_appbar_title').tr(),
        actions: [
          BlocBuilder<LanguageCubit, String>(
            builder: (context, state) {
              return DropdownButton(
                  style: const TextStyle(color: Colors.white),
                  underline: Container(),
                  dropdownColor: Colors.blue,
                  // dropdownColor: Colors.blue,
                  icon: const Icon(Icons.language),
                  iconEnabledColor: Colors.white,
                  value: state,
                  // focusColor: Colors.white,
                  items: languageList.map((String lan) {
                    return DropdownMenuItem(
                      value: lan,
                      child: Text(
                        lan,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? lan) {
                    if (lan == 'Eng') {
                      context.setLocale(const Locale('en'));
                    } else {
                      context.setLocale(const Locale('ur'));
                    }
                    context.read<LanguageCubit>().chnageLanguage(lan!);
                  });
            },
          )
        ],
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
                    labelText: 'email'.tr(),
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
                  labelText: 'password'.tr(),
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
                      showSnackBar(context, 'enter_email_password'.tr());
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
                          showSnackBar(context, 'no_user_registered'.tr());
                        }
                      }
                      if (loginState is UserLoginSocketException) {
                        showSnackBar(context, 'no_internet'.tr());
                      }

                      if (loginState is UserLoginBadRequest) {
                        showSnackBar(context, 'wrong_email_password'.tr());
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
                                : Text('login'.tr(),
                                    style: const TextStyle(
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
                      showSnackBar(context, 'enter_email_password'.tr());
                    }
                  },
                  child: BlocConsumer<UserRegisterCubit, UserRegisterState>(
                    listener: (context, registerState) {
                      if (registerState is UserRegisterLoaded) {
                        showSnackBar(context, 'user_added_successfully'.tr());
                      }
                      if (registerState is UserRegisterSocketException) {
                        showSnackBar(context, 'no_internet'.tr());
                      }
                      if (registerState is UserLoginBadRequest) {
                        showSnackBar(context, 'wrong_email_password'.tr());
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
                                : Text('register'.tr(),
                                    style: const TextStyle(
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

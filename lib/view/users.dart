import 'package:cubit_task/Controller/Cubits/UserDataCubit/user_cubit.dart';
import 'package:cubit_task/Models/DataController/user_controler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Cubits/UserDataCubit/user_state.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  // late UserModel? model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getModel();
    context.read<UserCubit>().fetchUsers();
  }

  getModel() async {
    // model = await BlocProvider.of<UserCubit>(context).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('api_cubit_state').tr()),
      body: BlocBuilder<UserCubit, UserState>(builder: (_, state) {
        if (state is UserCubitLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is UserCubitLoaded) {
          return ListView.builder(
              itemCount: UserControler.userModel!.data!.length,
              itemBuilder: (_, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Image.network(
                          UserControler.userModel!.data![index]!.avatar!),
                    ),
                    title: Text(
                        "${UserControler.userModel!.data![index]!.firstName!} ${UserControler.userModel!.data![index]!.lastName!}"),
                    subtitle:
                        Text(UserControler.userModel!.data![index]!.email!),
                  ),
                );
              });
        }
        if (state is UserCubitInitial) {
          return const Text('initial_state').tr();
        }
        if (state is UserSocketException) {
          return Center(
            child: const Text('no_internet').tr(),
          );
        }
        if (state is TokenExpire) {
          return Center(
            child: const Text("token_expire").tr(),
          );
        }
        return Container();
      }),
    );
  }
}

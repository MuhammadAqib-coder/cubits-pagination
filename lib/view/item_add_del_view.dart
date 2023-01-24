import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Const/const_data.dart';
import '../Controller/Cubits/StringCubit/language_cubit.dart';
import '../Controller/Cubits/boolCubits/box_cubit.dart';
import '../Controller/Cubits/listCubits/simple_list_cubit.dart';
import '../Utils/routes/routes_name.dart';

class ItemAddDelView extends StatelessWidget {
  ItemAddDelView({super.key});
  var length = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('list_with_cubit').tr(),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocConsumer<SimpleListCubit, List<String>>(
              listener: ((context, state) {
            if (length < state.length) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('item_added').tr()));
              length++;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('item_deleted').tr()));
              length--;
            }
          }), builder: (context, listState) {
            return Expanded(
                child: listState.isEmpty
                    ? Center(child: const Text('no_data').tr())
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: listState.length,
                        itemBuilder: (_, index) {
                          return Card(
                            child: BlocBuilder<BoxCubit, List<bool>>(
                              builder: (_, boxState) {
                                return ListTile(
                                  leading: Checkbox(
                                      value: boxState[index],
                                      onChanged: (value) {
                                        // list[index] = value!;
                                        context
                                            .read<BoxCubit>()
                                            .boxStateChange(value, index);
                                        // context
                                        //     .read<SimpleListCubit>()
                                        //     .removeItem(index);
                                      }),
                                  title: Text(listState[index]),
                                  trailing: boxState[index]
                                      ? IconButton(
                                          onPressed: () {
                                            // listState.removeAt(index);
                                            context
                                                .read<SimpleListCubit>()
                                                .removeItem(index);

                                            context
                                                .read<BoxCubit>()
                                                .removeBox(index);
                                          },
                                          icon: const Icon(Icons.delete))
                                      : const SizedBox(),
                                );
                              },
                            ),
                          );
                        }));
          }),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<SimpleListCubit>().addItem('item_added'.tr());
                    context.read<BoxCubit>().addBox(false);
                  },
                  child: const Text('add_item').tr()),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RoutesName.secondExample);
                  },
                  child: const Text('next_example').tr()),
            ],
          )
        ],
      ),
    );
  }
}

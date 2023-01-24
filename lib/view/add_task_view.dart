import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Cubits/boolCubits/box_cubit.dart';
import '../Controller/Cubits/boolCubits/true_box_cubit.dart';
import '../Controller/Cubits/listCubits/complete_task_list_cubit.dart';
import '../Controller/Cubits/listCubits/new_list_task_cubit.dart';
import '../Utils/routes/routes_name.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('new_task').tr(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocBuilder<NewTaskListCubit, List<String>>(
              builder: (context, newListState) {
            return Expanded(
                child: newListState.isEmpty
                    ? Center(child: const Text('no_task_available').tr())
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: newListState.length,
                        itemBuilder: (_, index) {
                          return Card(
                            child: BlocBuilder<BoxCubit, List<bool>>(
                              builder: (_, boxState) {
                                return ListTile(
                                  leading: Checkbox(
                                      value: boxState[index],
                                      onChanged: (value) {
                                        // list[index] = value!;
                                        // context
                                        //     .read<BoxCubit>()
                                        //     .boxStateChange(value, index);
                                        context
                                            .read<NewTaskListCubit>()
                                            .removeTask(index);
                                        context
                                            .read<BoxCubit>()
                                            .removeBox(index);
                                        context
                                            .read<CompleteTaskListCubit>()
                                            .addTask(newListState[index]);
                                        context
                                            .read<TrueBoxCubit>()
                                            .addBox(true);
                                      }),
                                  title: Text(newListState[index]),
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
                    context
                        .read<NewTaskListCubit>()
                        .addTask('new_task_added'.tr());
                    context.read<BoxCubit>().addBox(false);
                  },
                  child: const Text('add_task').tr()),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.completeTask);
                  },
                  child: const Text('completed_task').tr()),
            ],
          )
        ],
      ),
    );
  }
}

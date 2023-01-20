import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Cubits/boolCubits/box_cubit.dart';
import '../Controller/Cubits/boolCubits/true_box_cubit.dart';
import '../Controller/Cubits/listCubits/complete_task_list_cubit.dart';
import '../Controller/Cubits/listCubits/new_list_task_cubit.dart';

class CompleteTaskView extends StatelessWidget {
  const CompleteTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Task'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocBuilder<CompleteTaskListCubit, List<String>>(
              builder: (context, listState) {
            return Expanded(
                child: listState.isEmpty
                    ? const Center(child: Text('No Data'))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: listState.length,
                        itemBuilder: (_, index) {
                          return Card(
                            child: BlocBuilder<TrueBoxCubit, List<bool>>(
                              builder: (_, boxState) {
                                return ListTile(
                                    leading: Checkbox(
                                        value: boxState[index],
                                        onChanged: (value) {
                                          // list[index] = value!;
                                          context
                                              .read<TrueBoxCubit>()
                                              .removeBox(index);
                                          context
                                              .read<BoxCubit>()
                                              .addBox(false);
                                          context
                                              .read<CompleteTaskListCubit>()
                                              .removeTask(index);
                                          context
                                              .read<NewTaskListCubit>()
                                              .addTask('New Task Added');
                                        }),
                                    title: Text(listState[index]),
                                    trailing: IconButton(
                                        onPressed: () {
                                          // listState.removeAt(index);
                                          context
                                              .read<CompleteTaskListCubit>()
                                              .removeTask(index);

                                          context
                                              .read<TrueBoxCubit>()
                                              .removeBox(index);
                                        },
                                        icon: const Icon(Icons.delete)));
                              },
                            ),
                          );
                        }));
          }),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

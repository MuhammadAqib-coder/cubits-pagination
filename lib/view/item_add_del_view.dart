import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: const Text('List Cubit'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocConsumer<SimpleListCubit, List<String>>(
              listener: ((context, state) {
            if (length < state.length) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Item Added')));
              length++;
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Item Deleted')));
              length--;
            }
          }), builder: (context, listState) {
            return Expanded(
                child: listState.isEmpty
                    ? const Center(child: Text('No Data'))
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
                    context.read<SimpleListCubit>().addItem('Item added');
                    context.read<BoxCubit>().addBox(false);
                  },
                  child: const Text('Add Item')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RoutesName.secondExample);
                  },
                  child: const Text('Next Example')),
            ],
          )
        ],
      ),
    );
  }
}

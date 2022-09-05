import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/screens/RecycleBin.dart';
import 'package:flutter_better_muslim/screens/tasks_screen.dart';

import '../bloc/bloc_exports.dart';
import '../bloc/tasks/tasks_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: Column(children: [
        Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            child: Text('Task Drawer',
                style: Theme.of(context).textTheme.headline5)),
        BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(TasksScreen.id),
              child: ListTile(
                  leading: const Icon(Icons.folder_special),
                  title: const Text('My Tasks'),
                  trailing: Text('${state.allTasks.length}')),
            );
          },
        ),
        const Divider(),
        BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(RecyclerBin.id),
              child: ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Trash'),
                  trailing: Text('${state.removedTasks.length}')),
            );
          },
        )
      ]),
    ));
  }
}

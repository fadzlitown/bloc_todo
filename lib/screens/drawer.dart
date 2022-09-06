import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/screens/RecycleBin.dart';
import 'package:flutter_better_muslim/screens/tasks_screen.dart';

import '../bloc/bloc_exports.dart';
import '../bloc/tasks/tasks_bloc.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool switchVal = false;

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
              onTap: () =>
                  //todo Learning - pushNamed will stack the screen
                  //todo but pushReplacementNamed - will replace the existing screen (always 1 screen)
                  Navigator.of(context).pushReplacementNamed(TasksScreen.id),
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
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed(RecyclerBin.id),
              child: ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Trash'),
                  trailing: Text('${state.removedTasks.length}')),
            );
          },
        ),
        const Divider(),
        //todo if user pressed the Switch--> requires UI state, local var change --> required STATEFUL WIDGET !
        BlocBuilder<SwitchBloc, SwitchState>(
          builder: (context, state) {
            var stateValue = state.switchVal;

            return Switch(
                value: stateValue,
                onChanged: (val) {
                  setState(() {
                    // a way to dynamically change the UI state value, renders widget with latest state
                    stateValue = val;
                  });

                  val == true
                      ? context.read<SwitchBloc>().add(SwitchOn())
                      : context.read<SwitchBloc>().add(SwitchOff());
                });
          },
        )
      ]),
    ));
  }
}

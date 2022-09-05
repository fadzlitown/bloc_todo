import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../widgets/TasksList.dart';
import 'drawer.dart';

class RecyclerBin extends StatelessWidget {
  const RecyclerBin({Key? key}) : super(key: key);

  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          drawer: const MyDrawer(),
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text('Recycler Bin'),
            actions: [],
          ),

          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Chip(label: Text('Tasks:')),
              TasksList(list: state.removedTasks),
            ],
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}

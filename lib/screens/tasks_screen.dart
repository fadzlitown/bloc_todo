import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/TasksList.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // List<Task> list = [
  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const AddTaskScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> listTasks = state.allTasks;

        return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text('Task app'),
            actions: [
              IconButton(
                  onPressed: () => _addTask(context),
                  icon: const Icon(Icons.add))
            ],
          ),

          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chip(label: Text('Tasks: ${state.allTasks.length}')),
              TasksList(list: listTasks),
            ],
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

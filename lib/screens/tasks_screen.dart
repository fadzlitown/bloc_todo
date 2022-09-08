import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/TasksList.dart';
import 'add_task_screen.dart';
import 'drawer.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);
  static const id = 'tasks_screen';

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // List<Task> list = [

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> listTasks = state.allTasks;
        //todo remove the Scaffold since we already moved to TABS SCREEN
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chip(label: Text('Tasks: ${state.allTasks.length}')),
            TasksList(list: listTasks),
          ],
        );
      },
    );
  }
}

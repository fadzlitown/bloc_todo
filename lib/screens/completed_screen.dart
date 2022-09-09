import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/TasksList.dart';
import 'add_task_screen.dart';
import 'drawer.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);
  static const id = 'tasks_screen';

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  // List<Task> list = [

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> listTasks = state.completedTasks;
        //todo remove the Scaffold since we already moved to TABS SCREEN
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chip(label: Text('Tasks: ${state.completedTasks.length}')),
            TasksList(list: listTasks),
          ],
        );
      },
    );
  }
}

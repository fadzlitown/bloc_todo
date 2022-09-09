import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/TasksList.dart';
import 'add_task_screen.dart';
import 'drawer.dart';

class PendingTasksScreen extends StatefulWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);
  static const id = 'tasks_screen';

  @override
  State<PendingTasksScreen> createState() => _PendingTasksScreenState();
}

class _PendingTasksScreenState extends State<PendingTasksScreen> {
  // List<Task> list = [

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> listTasks = state.pendingTasks;
        //todo remove the Scaffold since we already moved to TABS SCREEN
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chip(
                label: Text(
                    '${state.pendingTasks.length} Pending | ${state.completedTasks.length} completed')),
            TasksList(list: listTasks),
          ],
        );
      },
    );
  }
}

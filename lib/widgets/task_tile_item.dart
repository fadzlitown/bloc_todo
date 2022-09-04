import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../models/task.dart';

class TaskTileItem extends StatelessWidget {
  const TaskTileItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(task.title,
            style: TextStyle(
                decoration: task.isDone!
                    ? TextDecoration.lineThrough
                    : TextDecoration.none)),
        trailing: Checkbox(
            onChanged: (value) {
              context.read<TasksBloc>().add(UpdateTask(task: task));
            },
            value: task.isDone),
        onLongPress: () =>
            context.read<TasksBloc>().add(DeleteTask(task: task)));
  }
}

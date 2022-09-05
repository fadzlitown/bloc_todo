import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../models/task.dart';

class TaskTileItem extends StatelessWidget {
  const TaskTileItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDeleteTask(BuildContext context, Task task) {
    context
        .read<TasksBloc>()
        .add(task.isDeleted! ? DeleteTask(task: task) : RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(task.title,
            style: TextStyle(
                decoration: task.isDone!
                    ? TextDecoration.lineThrough
                    : TextDecoration.none)),
        trailing: Checkbox(
            onChanged: task.isDeleted == false
                ? (value) {
                    context.read<TasksBloc>().add(UpdateTask(task: task));
                  }
                : null,
            value: task.isDone),
        onLongPress: () => _removeOrDeleteTask(context, task));
  }
}

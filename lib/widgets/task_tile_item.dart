import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/widgets/popup_menu.dart';
import 'package:intl/intl.dart';

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
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(children: [
              const Icon(Icons.star_outline),
              const SizedBox(width: 20), //extra space
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title,
                        overflow: TextOverflow.ellipsis, //avoid multiline title
                        style: TextStyle(
                            fontSize: 18,
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : TextDecoration.none)),
                    Text(DateFormat()
                        .add_yMEd()
                        .format(DateTime.now())) //DateTime.now().toString()
                  ],
                ),
              )
            ]),
          ),
          Row(
            children: [
              Checkbox(
                  onChanged: task.isDeleted == false
                      ? (value) {
                          context.read<TasksBloc>().add(UpdateTask(task: task));
                        }
                      : null,
                  value: task.isDone),
              PopupMenu(
                  cancelOrDeleteCallback: () =>
                      _removeOrDeleteTask(context, task),
                  task: task)
            ],
          )
        ],
      ),
    );
  }
}

// ListTile(
// title: Text(
// task.title,
// overflow: TextOverflow.ellipsis, //avoid multiline title
// style: TextStyle(
// decoration: task.isDone!
// ? TextDecoration.lineThrough
//     : TextDecoration.none)),
// trailing: Checkbox(
// onChanged: task.isDeleted == false
// ? (value) {
// context.read<TasksBloc>().add(UpdateTask(task: task));
// }
// : null,
// value: task.isDone),
// onLongPress: () => _removeOrDeleteTask(context, task));

import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/widgets/popup_menu.dart';
import 'package:intl/intl.dart';

import '../bloc/bloc_exports.dart';
import '../models/task.dart';
import '../screens/edit_task_screen.dart';

class TaskTileItem extends StatelessWidget {
  final VoidCallback likeCallback;

  TaskTileItem({
    Key? key,
    required this.task,
    required this.likeCallback,
  }) : super(key: key);
  Task task;

  void _removeOrDeleteTask(BuildContext context, Task task) {
    context
        .read<TasksBloc>()
        .add(task.isDeleted! ? DeleteTask(task: task) : RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled:
            true, //todo note: to make all widgets visible when phone's keypad show up!
        context: context,
        builder: (context) => SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: EditTaskScreen(oldTask: task))));
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
              task.isFav == false
                  ? const Icon(Icons.star_outline)
                  : const Icon(Icons.star),
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
                    Text(DateFormat().add_yMEd().add_Hm().format(
                        DateTime.parse(task.date))) //DateTime.now().toString()
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
                  likeOrDislikeCallback: likeCallback,
                  editTaskCallback: () {
                    Navigator.of(context).pop();
                    _editTask(context);
                  },
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

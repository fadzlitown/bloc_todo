import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/widgets/task_tile_item.dart';

import '../models/task.dart';

class TasksList extends StatelessWidget {
  final List<Task> list;

  const TasksList({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemBuilder: (context, index) {
            var task = list[index];
            return TaskTileItem(task: task);
          },
          itemCount: list.length),
    );
  }
}

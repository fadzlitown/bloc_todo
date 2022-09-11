import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/bloc/bloc_exports.dart';
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
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
            elevation: 3,
            key: UniqueKey(),
            children: list
                .map((task) => ExpansionPanelRadio(
                    value: task.id,
                    headerBuilder: (context, canHeaderOpen) => TaskTileItem(
                        task: task,
                        likeCallback: () => context.read<TasksBloc>().add(
                            LikeOrDislikeTask(task: task))), //todo revert back
                    body: ListTile(
                      title: SelectableText.rich(TextSpan(children: [
                        const TextSpan(
                            text: 'Title:\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: task.title),
                        const TextSpan(
                            text: '\n\nDesc:\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: task.desc),
                      ])),
                    )))
                .toList()),
      ),
    );
  }
}

// Expanded(
// child: ListView.builder(
// itemBuilder: (context, index) {
// var task = list[index];
// return TaskTileItem(task: task);
// },
// itemCount: list.length),
// );

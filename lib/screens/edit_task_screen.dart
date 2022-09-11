import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;

  const EditTaskScreen({
    Key? key,
    required this.oldTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleC = TextEditingController(text: oldTask.title);
    TextEditingController descC = TextEditingController(text: oldTask.desc);

    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const Text(
            'Add Task Here',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10),
          TextField(
            autofocus: true,
            controller: titleC,
            decoration: const InputDecoration(
                label: Text('Title'), border: OutlineInputBorder()),
          ),
          TextField(
              autofocus: true,
              controller: descC,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                  label: Text('Desc'), border: OutlineInputBorder())),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  //just close the bottomsheet
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    var editedTask = Task(
                        title: titleC.text,
                        desc: descC.text,
                        date: DateTime.now().toString(),
                        isFav: oldTask.isFav,
                        isDone: false,
                        id: oldTask
                            .id); //keep the old id, as this id will be updated in db
                    context
                        .read<TasksBloc>()
                        .add(EditTask(oldTask: oldTask, newTask: editedTask));
                    Navigator.pop(context);
                  },
                  child: const Text('Save')),
            ],
          )
        ],
      ),
    );
  }
}

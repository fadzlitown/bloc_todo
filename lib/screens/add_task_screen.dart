import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/bloc/bloc_exports.dart';

import '../models/task.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleC = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const Text(
            'Add Task Here',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 8),
          TextField(
            autofocus: true,
            controller: titleC,
            decoration: const InputDecoration(
                label: Text('Title'), border: OutlineInputBorder()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  //just close the bottomsheet
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    var task = Task(
                        title: titleC.text,
                        id: UniqueKey()
                            .hashCode
                            .toString()); //or DateTime.now().millisecondsSinceEpoch todo done improvement
                    context.read<TasksBloc>().add(AddTask(task: task));
                    Navigator.pop(context);
                  },
                  child: const Text('Add')),
            ],
          )
        ],
      ),
    );
  }
}

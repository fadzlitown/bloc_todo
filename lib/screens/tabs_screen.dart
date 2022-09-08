import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/screens/drawer.dart';
import 'package:flutter_better_muslim/screens/tasks_screen.dart';

import 'add_task_screen.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  static const id = 'tabs_screen';

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const AddTaskScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabs Screen'),
        actions: [
          IconButton(
              onPressed: () => _addTask(context), icon: const Icon(Icons.add))
        ],
      ),
      drawer: const MyDrawer(),
      body: const TasksScreen(),
      // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Pending List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done), label: 'Completed List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourate List')
        ],
      ),
    );
  }
}

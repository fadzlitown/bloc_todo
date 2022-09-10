import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/screens/drawer.dart';
import 'package:flutter_better_muslim/screens/pending_screen.dart';

import 'add_task_screen.dart';
import 'completed_screen.dart';
import 'fav_screen.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({Key? key}) : super(key: key);

  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //Seperate list of maps
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': const PendingTasksScreen(), 'title': 'Pending Tasks'},
    {'pageName': const CompletedTasksScreen(), 'title': 'Completed Tasks'},
    {'pageName': const FavTasksScreen(), 'title': 'Fav Tasks'},
  ];

  //to keep this value using bottom nav, so stateful widget required in this screen!
  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled:
            true, //todo note: to make all widgets visible when phone's keypad show up!
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
        title: Text(_pageDetails[_selectedPageIndex]['title']),
        actions: [
          IconButton(
              onPressed: () => _addTask(context), icon: const Icon(Icons.add))
        ],
      ),
      drawer: const MyDrawer(),
      body: _pageDetails[_selectedPageIndex]
          ['pageName'], //body of the container should be dynamic page
      // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle_sharp), label: 'Pending List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done), label: 'Completed List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourate List')
        ],
      ),
    );
  }
}

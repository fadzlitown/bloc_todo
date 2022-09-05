import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/screens/RecycleBin.dart';
import 'package:flutter_better_muslim/screens/tasks_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecyclerBin.id:
        return MaterialPageRoute(builder: (_) => const RecyclerBin());
      case TasksScreen.id:
        return MaterialPageRoute(builder: (_) => const TasksScreen());
      default:
        return null;
    }
  }
}

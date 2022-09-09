import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/screens/RecycleBin.dart';
import 'package:flutter_better_muslim/screens/tabs_screen.dart';
import 'package:flutter_better_muslim/screens/pending_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecyclerBin.id:
        return MaterialPageRoute(builder: (_) => const RecyclerBin());
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_) => TabsScreen());
      default:
        return null;
    }
  }
}

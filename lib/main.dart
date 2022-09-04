import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/bloc/bloc_exports.dart';
import 'package:path_provider/path_provider.dart';

import 'screens/tasks_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hydratedStorage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  // BlocOverrides.runZoned(() => runApp(const MyApp()));
  HydratedBlocOverrides.runZoned(() => runApp(const MyApp()),
      storage: hydratedStorage); //Hydrated storage will call native method
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const TasksScreen(),
      ),
    );
  }
}

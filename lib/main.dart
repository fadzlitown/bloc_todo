import 'package:flutter/material.dart';
import 'package:flutter_better_muslim/bloc/bloc_exports.dart';
import 'package:flutter_better_muslim/screens/tabs_screen.dart';
import 'package:flutter_better_muslim/service/app_route.dart';
import 'package:flutter_better_muslim/service/app_theme.dart';
import 'package:path_provider/path_provider.dart';

import 'screens/tasks_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hydratedStorage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  // BlocOverrides.runZoned(() => runApp(const MyApp()));
  HydratedBlocOverrides.runZoned(() => runApp(MyApp(appRouter: AppRouter())),
      storage: hydratedStorage); //Hydrated storage will call native method
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //1 Bloc = BlocProvider
    //More 1 bloc = MultiBlocProvider
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc())
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.switchVal
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const TabsScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}

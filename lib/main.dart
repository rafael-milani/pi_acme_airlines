import 'package:acme_airlines_pi/screens/tabs_screen.dart';
import 'package:acme_airlines_pi/services/app_router.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:acme_airlines_pi/screens/login.dart';
import 'package:acme_airlines_pi/screens/pending_screen.dart';

import 'blocs/bloc_exports.dart';
import 'screens/add_task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp( Aplicativo(appRouter: AppRouter(),));
}

class Aplicativo extends StatelessWidget {
  const Aplicativo({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => const Login(),
          "principal/": (context) => TabsScreen(),
        },
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}

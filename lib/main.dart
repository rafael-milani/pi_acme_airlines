import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:acme_airlines_pi/screens/login.dart';
import 'package:acme_airlines_pi/screens/principal.dart';

import 'blocs/bloc_exports.dart';
import 'screens/add_task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const Aplicativo());
}

class Aplicativo extends StatelessWidget {
  const Aplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => const Login(),
          "principal/": (context) => const Principal(),
        },
      ),
    );
  }
}

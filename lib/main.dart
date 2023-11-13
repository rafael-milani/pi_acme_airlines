import 'package:acme_airlines_pi/blocs/bloc/tasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:acme_airlines_pi/screens/login.dart';
import 'package:acme_airlines_pi/screens/principal.dart';

import 'blocs/bloc_exports.dart';
import 'models/task.dart';

void main() {
  BlocOverrides.runZoned(
  () => runApp(const Aplicativo()),
  );
}

class Aplicativo extends StatelessWidget {
  const Aplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc()
      ..add(AddTask(
        task: Task(title: 'Task1')
      )),
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

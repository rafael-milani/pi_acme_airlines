import 'package:acme_airlines_pi/blocs/bloc_exports.dart';
import 'package:acme_airlines_pi/screens/principal.dart';
import 'package:acme_airlines_pi/screens/recycle_bin.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            color: Colors.white,
            child: Text(
              'Task Drawer',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(Principal.id),
                child: ListTile(
                  leading: Icon(Icons.folder_special),
                  title: Text('Minhas Tasks'),
                  trailing: Text('${state.allTasks.length}'),
                ),
              );
            },
          ),
           const Divider(),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(RecycleBin.id),
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Lixeira'),
                  trailing: Text('${state.removedTasks.length}'),
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}

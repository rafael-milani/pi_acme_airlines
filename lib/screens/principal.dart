import 'package:acme_airlines_pi/widgets/tasks_list.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => PrincipalState();
}

class PrincipalState extends State<Principal> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            title: Text('Alertas'),
            toolbarHeight: 80,
            centerTitle: true,
            elevation: 0,
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                const Center(
                  child: Chip(
                    label: Text(
                      'Tasks',
                    ),
                  ),
                ),  
                TasksList(taskList: tasksList)
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){},
              tooltip: 'Add task',
              child: const Icon(Icons.add),
              ),
        );
      },
    );
  }
}

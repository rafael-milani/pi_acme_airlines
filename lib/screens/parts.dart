import 'package:acme_airlines_pi/screens/add_task_screen.dart';
import 'package:acme_airlines_pi/screens/my_drawer.dart';
import 'package:acme_airlines_pi/widgets/tasks_list.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);
  static const id = 'storage_screen';
  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.completedTasks;
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    '${tasksList.length} Peças',
                  ),
                ),
              ),
              TasksList(taskList: tasksList)
            ],
          );
      },
    );
  }
}

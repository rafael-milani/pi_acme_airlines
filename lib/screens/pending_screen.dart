import 'package:acme_airlines_pi/screens/add_task_screen.dart';
import 'package:acme_airlines_pi/screens/my_drawer.dart';
import 'package:acme_airlines_pi/widgets/tasks_list.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);
  static const id = 'principal_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.pendingTasks;
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    '${tasksList.length} Tasks Pendentes | ${state.completedTasks.length} Tasks Concluidas',
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

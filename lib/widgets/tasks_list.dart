import 'package:acme_airlines_pi/blocs/bloc_exports.dart';
import 'package:acme_airlines_pi/models/task.dart';
import 'package:flutter/material.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.taskList,
  });

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context,index){
          var task = taskList[index];
          return ListTile(
            title: Text(task.title),
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (value){
                context.read<TasksBloc>().add(UpdateTask(task: task));
              },
            ),
          );
        }),
    );
  }
}

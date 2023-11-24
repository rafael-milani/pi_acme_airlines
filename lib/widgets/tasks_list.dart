import 'package:acme_airlines_pi/blocs/bloc_exports.dart';
import 'package:acme_airlines_pi/models/task.dart';
import 'package:acme_airlines_pi/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.taskList,
  });

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: taskList
          .map((task) => ExpansionPanelRadio(
              value: task.id, 
              headerBuilder: (context, isOpen) => TaskTile(task: task), 
              body: ListTile(
                title: SelectableText.rich(TextSpan(children: [
                    const TextSpan(
                      text: 'Task\n ', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                        ),
                      ),
                      TextSpan(text: task.title),
                    const TextSpan(
                      text: '\n\nDescrição\n ', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                        ),
                      ),
                      TextSpan(text: task.description),
                  ])),
              )))
              .toList(),
        ),
      ),
    );
  }
}

/*
Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context,index){
          var task = taskList[index];
          return TaskTile(task: task);
        }),
    );
*/
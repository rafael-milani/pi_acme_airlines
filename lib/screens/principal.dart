import 'package:flutter/material.dart';

import '../models/task.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => PrincipalState();
}

class PrincipalState extends State<Principal> {
  
  List<Task> taskList = [
    Task(title: 'Task 1'),
    Task(title: 'Task 2'),
    Task(title: 'Task 3'),
  ];

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context,index){
                  var task = taskList[index];
                  return ListTile(
                    title: Text(task.title),
                    trailing: Checkbox(
                      value: task.isDone,
                      onChanged: (value){},
                    ),
                  );
                }),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          tooltip: 'Add task',
          child: const Icon(Icons.add),
          ),
    );
  }
}

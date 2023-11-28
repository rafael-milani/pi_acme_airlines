import 'dart:convert';
import 'package:acme_airlines_pi/screens/task_details.dart';
import 'package:acme_airlines_pi/widgets/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);
  static const id = 'principal_screen';
  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  var tasks = [];
  var allTasks = [];

  @override
  void initState() {
    loadTasks();

    super.initState();
  }

  void loadTasks() async {
    final url = Uri.parse('https://skystop.onrender.com/maintenances');

    final response = await http.get(url);

    setState((){
      allTasks = jsonDecode(response.body);
      tasks = allTasks.where((task) => task['status'] != 'OPEN').toList();
    });
    
    print(tasks);
  }

  void showTaskDetails(BuildContext context, task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: TaskDetailsScreen(task: task),
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Chip(
                    label: Text(
                      '${tasks.length} Manutenções Concluídas',
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for(var task in tasks) GestureDetector(
                      onTap: () => showTaskDetails(context, task),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text('ID', style: TextStyle(color: Colors.grey[800], fontSize: 10)),
                                      Text(task['id'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                                    ],
                                  ),
                                  const SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Título', style: TextStyle(color: Colors.grey[800], fontSize: 10)),
                                      Text(task['motive_title'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(task['motive_description'].toString(), style: const TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('Requisitor', style: TextStyle(color: Colors.grey[800], fontSize: 10)),
                                      Text(task['requester_email'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        )
                      )
                    )
                  ],
                )
              ],
            )
          )
      )
    );
  }
}

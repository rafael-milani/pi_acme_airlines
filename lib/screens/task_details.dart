import 'dart:convert';
import 'package:acme_airlines_pi/widgets/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class TaskDetailsScreen extends StatefulWidget {
  final task;

  const TaskDetailsScreen({super.key, this.task});

  @override
  State<TaskDetailsScreen> createState() {
    return _TaskDetailsScreenState();
  }
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  var taskDetails;

  @override
  void initState() {
    taskDetails = widget.task;
    taskDetails['part_requests'] = [];
    taskDetails['part_removal'] = [];
    taskDetails['workers'] = [];
    taskDetails['checklist'] = [];

    loadTaskDetails();

    super.initState();
  }

  void loadTaskDetails() async {
    final url = Uri.parse('https://skystop.onrender.com/maintenance/details');
    final jsonBody = {
      'maintenance': taskDetails['id'],
    };
    final body = jsonEncode(jsonBody);
    final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);

    setState((){
      taskDetails = jsonDecode(response.body);
    });
    
    print(taskDetails);
  }


  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('✕', style: TextStyle(fontSize: 40, color: Colors.black)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${taskDetails['id'].toString()}- ${taskDetails['motive_title']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            ],
          ),
          Row(
            children: [
              Text('Requester', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
            ]
          ),
          Row(
            children: [
              Flexible(
                child: Text(taskDetails['requester_email'], style: TextStyle(fontSize: 14, color: Colors.grey[800]))
              )
            ]
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text('Status', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
            ]
          ),
          Row(
            children: [
              Flexible(
                child: Text(taskDetails['status'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: taskDetails['status'] == 'OPEN' ? Colors.green : Colors.grey[800]))
              )
            ]
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text('Description', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
            ]
          ),
          Row(
            children: [
              Flexible(
                child: Text(taskDetails['motive_description'], style: const TextStyle(fontSize: 16))
              )
            ]
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text('Instructions', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
            ]
          ),
          Row(
            children: [
              Flexible(
                child: Text(taskDetails['instructions'], style: const TextStyle(fontSize: 16))
              )
            ]
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text('Parts requested for this maintenance', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
            ]
          ),
          Row(
            children: [
              Column(
                children: <Widget>[
                  for(var part in taskDetails['part_requests']) SizedBox(
                    width: 350,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Model ID', style: TextStyle(color: Colors.grey[800], fontSize: 10)),
                                          Text(part['model_id'].toString(), style: const TextStyle(fontSize: 18))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Unit ID', style: TextStyle(color: Colors.grey[800], fontSize: 10)),
                                          Text(part['id'], style: const TextStyle(fontSize: 18))
                                        ],
                                      )
                                    ],
                                  ),
                                ]
                              )
                            ],
                          )
                        )
                      )
                    )
                  )
                ]
              )
            ]
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text('Parts removed during maintenance', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
            ]
          ),
          Row(
            children: [
              Column(
                children: <Widget>[
                  for(var part in taskDetails['part_removal']) SizedBox(
                    width: 350,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Model ID', style: TextStyle(color: Colors.grey[800], fontSize: 10)),
                                          Text(part['model_id'].toString(), style: const TextStyle(fontSize: 18))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Unit ID', style: TextStyle(color: Colors.grey[800], fontSize: 10)),
                                          Text(part['id'], style: const TextStyle(fontSize: 18))
                                        ],
                                      )
                                    ],
                                  ),
                                ]
                              )
                            ],
                          )
                        )
                      )
                    )
                  )
                ]
              )
            ]
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text('Workers requested for maintenance', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
            ]
          ),
          Row(
            children: [
              Column(
                children: <Widget>[
                  for(var worker in taskDetails['workers']) SizedBox(
                    width: 350,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Email', style: TextStyle(color: Colors.grey[800], fontSize: 10)),
                                          Text(worker['email'], style: const TextStyle(fontSize: 18))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Name', style: TextStyle(color: Colors.grey[800], fontSize: 10)),
                                          Text("${worker['name']} ${worker['surname']}", style: const TextStyle(fontSize: 18))
                                        ],
                                      )
                                    ],
                                  ),
                                ]
                              )
                            ],
                          )
                        )
                      )
                    )
                  )
                ]
              )
            ]
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text('Checklist', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
            ]
          ),
          Row(
            children: [
              Column(
                children: <Widget>[
                  for(var item in taskDetails['checklist']) SizedBox(
                    width: 350,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item['label'], style: const TextStyle(fontSize: 16)),
                          Checkbox(
                            value: false,
                            onChanged: (newValue) {
                              item['done'] = newValue;
                            }
                          )
                        ],
                      )
                    )
                  )
                ]
              )
            ]
          )
        ],
      )
    );
  }
}

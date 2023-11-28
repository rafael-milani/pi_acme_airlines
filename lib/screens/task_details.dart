import 'dart:convert';
import 'package:acme_airlines_pi/screens/add_checklist_item_screen.dart';
import 'package:acme_airlines_pi/screens/add_part_removal_screen.dart';
import 'package:acme_airlines_pi/screens/request_worker_screen.dart';
import 'package:acme_airlines_pi/widgets/tasks_list.dart';
import 'package:acme_airlines_pi/screens/add_part_request_screen.dart';
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

class _TaskDetailsScreenState extends State<TaskDetailsScreen>{
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

  void addPartRequest(BuildContext context, maintenance_id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddPartRequestScreen(maintenance_id: maintenance_id),
        )
      )
    ).then((_) => loadTaskDetails());
  }

  void addPartRemoval(BuildContext context, maintenance_id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddPartRemovalScreen(maintenance_id: maintenance_id),
        )
      )
    ).then((_) => loadTaskDetails());
  }

  void requestWorker(BuildContext context, maintenance_id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: RequestWorkerScreen(maintenance_id: maintenance_id),
        )
      )
    ).then((_) => loadTaskDetails());
  }

  void addChecklistItem(BuildContext context, maintenance_id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddChecklistItemScreen(maintenance_id: maintenance_id),
        )
      )
    ).then((_) => loadTaskDetails());
  }

  void setChecklistItem(BuildContext context, boolValue, item_id) async {
    var value;

    boolValue ? value = 1 : value = 0;

    final url = Uri.parse('https://skystop.onrender.com/maintenance/change_checklist_item');
    final jsonBody = {
      'value': value,
      'item': item_id
    };
    final body = jsonEncode(jsonBody);
    final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
    
    print(taskDetails);
  }

  void confirmTaskCompletion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Confirme que deseja finalizar esta manutenção.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: TextStyle(color: Colors.grey[800])),
          ),
          TextButton(
            onPressed: () {
              completeTask();
              Navigator.pop(context);
            },
            child: Text('Confirmar', style: TextStyle(color: Colors.green[600])),
          ),
        ],
      ),
    );
  }

  void completeTask() async {
    final url = Uri.parse('https://skystop.onrender.com/maintenance/set_status');
    final jsonBody = {
      'id': taskDetails['id'],
      'status': 'COMPLETED'
    };
    final body = jsonEncode(jsonBody);
    final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
    
    print(taskDetails);

    loadTaskDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 40
                )
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
              Text('Requisitor', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
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
              Text('Descrição', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
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
              Text('Instruções', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
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
              Text('Peças requeridas para esta manutenção', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
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
                                    const SizedBox(width: 10),
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
                  ),
                  if(taskDetails['status'] != 'COMPLETED') SizedBox(
                    width: 350,
                    height: 60,
                    child: GestureDetector(
                      onTap: () => addPartRequest(context, taskDetails['id']),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('+', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.green[800]))
                            ]
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
              Text('Peças removidas nesta manutenção', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
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
                                    const SizedBox(width: 10),
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
                  ),
                  if(taskDetails['status'] != 'COMPLETED') SizedBox(
                    width: 350,
                    height: 60,
                    child: GestureDetector(
                      onTap: () => addPartRemoval(context, taskDetails['id']),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('+', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.red[800]))
                            ]
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
              Text('Funcionários requisitados para esta manutenção', style: TextStyle(color: Colors.grey[800], fontSize: 12)),
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
                                    const SizedBox(width: 10),
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
                  ),
                  if(taskDetails['status'] != 'COMPLETED') SizedBox(
                    width: 350,
                    height: 60,
                    child: GestureDetector(
                      onTap: () => requestWorker(context, taskDetails['id']),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('+', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.orange[800]))
                            ]
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item['label'], style: const TextStyle(fontSize: 16)),
                        Checkbox(
                          value: item['done']['data'][0] == 1 ? true : false,
                          onChanged: (newValue){
                            setState(() {
                              item['done']['data'][0] = newValue! ? 1 : 0;
                            });
                            setChecklistItem(context, newValue, item['id']);
                          }
                        )
                      ],
                    )
                  ),
                  if(taskDetails['status'] != 'COMPLETED') SizedBox(
                    width: 350,
                    height: 60,
                    child: GestureDetector(
                      onTap: () => addChecklistItem(context, taskDetails['id']),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('+', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.blue[800]))
                            ]
                          )
                        )
                      )
                    )
                  )
                ]
              )
            ]
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if(taskDetails['status'] != 'COMPLETED') SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () => confirmTaskCompletion(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color?>(Colors.green[800]),
                    foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Finalizar Manutenção', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Icon(Icons.check, size: 40)
                    ],
                  )
                )
              )
            ]
          )
        ],
      )
    );
  }
}

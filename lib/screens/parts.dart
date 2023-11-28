import 'dart:convert';
import 'package:acme_airlines_pi/widgets/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);
  static const id = 'storage_screen';
  @override
  State<StorageScreen> createState() => StorageScreenState();
}

class StorageScreenState extends State<StorageScreen> {
  var partModels = [];
  var partUnits = [];
  bool loadingParts = false;

  @override
  void initState() {
    loadParts();

    super.initState();
  }

  void loadParts() async {
    loadingParts = true;

    final modelsUrl = Uri.parse('https://skystop.onrender.com/parts/models');
    final unitsUrl = Uri.parse('https://skystop.onrender.com/parts/units');

    final responses = await Future.wait([http.get(modelsUrl), http.get(unitsUrl)]);

    setState((){
      partModels = jsonDecode(responses[0].body);
      partUnits = jsonDecode(responses[1].body);
    });
    
    print(partUnits);

    loadingParts = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              for(var model in partModels) if(partUnits.map((unit) => unit['model_id']).contains(model['id'])) ExpansionTile(
                title: Text("${model['id']}- ${model['model']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(model['category']),
                children: <Widget>[
                  for(var unit in partUnits) if(unit['model_id'] == model['id']) Card(
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Row(
                        children: [
                          Icon(
                            Icons.apps,
                            color: unit['availability'] == 'AVAILABLE' ? Colors.green : Colors.red[800],
                            size: 36
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Unit ID', style: TextStyle(color: Colors.grey[800], fontSize: 10)),
                                      Text(unit['id'], style: const TextStyle(fontSize: 18))
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(unit['availability'], style: TextStyle(
                                  color: unit['availability'] == 'AVAILABLE' ? Colors.green : Colors.red[800],
                                  fontSize: 16,
                                ))
                              )
                              
                            ]
                          )
                        ],
                      )
                    )
                  )
                ],
              ),
            ],
          )
        )
      )
    );
  }
}

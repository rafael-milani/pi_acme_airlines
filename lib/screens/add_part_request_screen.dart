import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPartRequestScreen extends StatefulWidget {
  final maintenance_id;

  const AddPartRequestScreen({super.key, this.maintenance_id});

  @override
  State<AddPartRequestScreen> createState() {
    return AddPartRequestScreenState();
  }
}

class AddPartRequestScreenState extends State<AddPartRequestScreen> {
  var maintenance_id;
  var partUnits = [];
  var partModels = [];

  final TextEditingController modelController = TextEditingController();
  final TextEditingController unitController = TextEditingController();

  @override
  void initState(){
    maintenance_id = widget.maintenance_id;

    loadParts();

    super.initState();
  }

  void loadParts() async {
    final modelsUrl = Uri.parse('https://skystop.onrender.com/parts/models');
    final unitsUrl = Uri.parse('https://skystop.onrender.com/parts/units');

    final responses = await Future.wait([http.get(modelsUrl), http.get(unitsUrl)]);

    var allPartUnits = jsonDecode(responses[1].body);

    setState((){
      partModels = jsonDecode(responses[0].body);
      partUnits = allPartUnits.where((unit) => unit['availability'] == 'AVAILABLE').toList();
    });
    
    print(partUnits);
  }

  void createPartRequest(String model_id, String unit_id) async {
    final url = Uri.parse('https://skystop.onrender.com/maintenance/request_part');
    final jsonBody = {
      'maintenance': maintenance_id,
      'part_model': model_id,
      'part_unit': unit_id
    };
    final body = jsonEncode(jsonBody);

    final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
    final responseStatus = response.statusCode;
    print(response.body);

    responseStatus == 200 ? Navigator.pop(context) : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entrada inválida - Insira um registro existente.')));;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Requerir Peça',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
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
                                  child: ElevatedButton(
                                    onPressed: () => createPartRequest(unit['model_id'].toString(), unit['id']),
                                    child: Text('Requerir peça', style: TextStyle(color: Colors.green[800]))
                                  )
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
          ]
        )
      )
    );
  }
}

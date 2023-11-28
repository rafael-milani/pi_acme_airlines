import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPartRemovalScreen extends StatefulWidget {
  final maintenance_id;

  const AddPartRemovalScreen({super.key, this.maintenance_id});

  @override
  State<AddPartRemovalScreen> createState() {
    return AddPartRemovalScreenState();
  }
}

class AddPartRemovalScreenState extends State<AddPartRemovalScreen> {
  var maintenance_id;

  final TextEditingController modelController = TextEditingController();
  final TextEditingController unitController = TextEditingController();

  @override
  void initState(){
    maintenance_id = widget.maintenance_id;

    super.initState();
  }

  void createPartRemoval(String model_id, String unit_id) async {
    final url = Uri.parse('https://skystop.onrender.com/maintenance/remove_part');
    final jsonBody = {
      'maintenance': maintenance_id,
      'part_model': model_id,
      'part_unit': unit_id
    };
    final body = jsonEncode(jsonBody);

    final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
    final responseStatus = response.statusCode;
    print(response.body);

    responseStatus == 200 ? Navigator.pop(context) : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entrada inválida - Insira um model_id válido.')));;
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
              'Remover Peça',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top:10, bottom: 10),
              child: TextField(
                autofocus: true,
                controller: modelController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Model ID'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            TextField(
              autofocus: true,
              controller: unitController,
              decoration: const InputDecoration(
                label: Text('Unit ID'),
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () => createPartRemoval(modelController.text, unitController.text),
                  child: const Text('Criar'),
                )
              ],
            )
          ]
        )
      )
    );
  }
}

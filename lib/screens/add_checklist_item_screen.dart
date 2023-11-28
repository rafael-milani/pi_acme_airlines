import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddChecklistItemScreen extends StatefulWidget {
  final maintenance_id;

  const AddChecklistItemScreen({super.key, this.maintenance_id});

  @override
  State<AddChecklistItemScreen> createState() {
    return AddChecklistItemScreenState();
  }
}

class AddChecklistItemScreenState extends State<AddChecklistItemScreen> {
  var maintenance_id;

  final TextEditingController labelController = TextEditingController();

  @override
  void initState(){
    maintenance_id = widget.maintenance_id;

    super.initState();
  }

  void addChecklistItem(String label) async {
    final url = Uri.parse('https://skystop.onrender.com/maintenance/create_checklist_item');
    final jsonBody = {
      'maintenance': maintenance_id,
      'label': label
    };
    final body = jsonEncode(jsonBody);

    final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
    final responseStatus = response.statusCode;
    print(response.body);

    responseStatus == 200 ? Navigator.pop(context) : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ocorreu um erro durante a criação do item.')));;
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
              'Adicionar Item para a Checklist',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top:10, bottom: 10),
              child: TextField(
                autofocus: true,
                controller: labelController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Label'),
                  border: OutlineInputBorder(),
                ),
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
                  onPressed: () => addChecklistItem(labelController.text),
                  child: const Text('Adicionar'),
                )
              ],
            )
          ]
        )
      )
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:acme_airlines_pi/blocs/bloc_exports.dart';
import 'package:acme_airlines_pi/models/task.dart';
import 'package:acme_airlines_pi/services/guid_gen.dart';
import 'package:acme_airlines_pi/screens/parts.dart';
import 'package:flutter/material.dart';
import 'package:acme_airlines_pi/globals.dart' as globals;

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() {
    return AddTaskScreenState();
  }
}

class AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController airshipController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();

  void createPart(String airship_id, String title, String description, String instructions) async {
    final url = Uri.parse('https://skystop.onrender.com/maintenance');
    final jsonBody = {
      'airship': airship_id,
      'title': title,
      'description': description,
      'instructions': instructions,
      'requester': globals.userEmail
    };
    final body = jsonEncode(jsonBody);

    final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
    final responseStatus = response.statusCode;
    print(response.body);

    responseStatus == 200 ? Navigator.pop(context) : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entrada inválida - Insira um airship_id existente.')));;
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
              'Criar Manutenção',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top:10, bottom: 10),
              child: TextField(
                autofocus: true,
                controller: airshipController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Airship ID'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            TextField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Título'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              autofocus: true,
              controller: descriptionController,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                label: Text('Descrição'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              autofocus: true,
              controller: instructionsController,
              minLines: 3,
              maxLines: 10,
              decoration: const InputDecoration(
                label: Text('Instruções'),
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
                  onPressed: () => createPart(airshipController.text, titleController.text, descriptionController.text, instructionsController.text),
                  child: const Text('Criar'),
                )
              ],
            ),
          ]
        )
      )
    );
  }
}

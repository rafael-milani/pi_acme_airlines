import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestWorkerScreen extends StatefulWidget {
  final maintenance_id;

  const RequestWorkerScreen({super.key, this.maintenance_id});

  @override
  State<RequestWorkerScreen> createState() {
    return RequestWorkerScreenState();
  }
}

class RequestWorkerScreenState extends State<RequestWorkerScreen> {
  var maintenance_id;

  final TextEditingController userController = TextEditingController();

  @override
  void initState(){
    maintenance_id = widget.maintenance_id;

    super.initState();
  }

  void requestWorker(String user) async {
    final url = Uri.parse('https://skystop.onrender.com/maintenance/request_worker');
    final jsonBody = {
      'maintenance': maintenance_id,
      'user': user
    };
    final body = jsonEncode(jsonBody);

    final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
    final responseStatus = response.statusCode;
    print(response.body);

    responseStatus == 200 ? Navigator.pop(context) : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entrada inválida - Insira um e-mail válido.')));;
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
              'Requerir Funcionário',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top:10, bottom: 10),
              child: TextField(
                autofocus: true,
                controller: userController,
                decoration: const InputDecoration(
                  label: Text('E-mail'),
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
                  onPressed: () => requestWorker(userController.text),
                  child: const Text('Requerir'),
                )
              ],
            )
          ]
        )
      )
    );
  }
}

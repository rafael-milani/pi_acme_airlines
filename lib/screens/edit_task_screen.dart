import 'package:acme_airlines_pi/blocs/bloc_exports.dart';
import 'package:acme_airlines_pi/models/task.dart';
import 'package:acme_airlines_pi/services/guid_gen.dart';
import 'package:flutter/material.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Editar Task',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top:10, bottom: 10),
              child: TextField(
                autofocus: true,
                controller: titleController,
                decoration: const InputDecoration(
                  label: Text('Titulo'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
             TextField(
              autofocus: true,
              controller: descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                label: Text('Descrição'),
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
                  onPressed: () {
                    var task = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    id: GUIDGen.generate(),
                    );
                    context.read<TasksBloc>().add(AddTask(task: task));
                    Navigator.pop(context);
                  },
                  child: const Text('Editar'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

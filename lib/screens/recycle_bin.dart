import 'package:acme_airlines_pi/blocs/bloc_exports.dart';
import 'package:acme_airlines_pi/screens/my_drawer.dart';
import 'package:acme_airlines_pi/widgets/tasks_list.dart';
import 'package:flutter/material.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});

  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
              appBar: AppBar(
                title: const Text('Lixeira'),
                toolbarHeight: 80,
                centerTitle: true,
                elevation: 0,
                actions: [
                  IconButton(
                    onPressed: () {} ,
                    icon: const Icon(Icons.add),
                   )
                ],
              ),
              drawer: MyDrawer(),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Chip(
                      label: Text(
                        '${state.removedTasks.length} Tasks',
                      ),
                    ),
                  ),
                  TasksList(taskList: state.removedTasks)
                ],
              ),
            );
      },
    );
  }
}
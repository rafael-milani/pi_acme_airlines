import 'package:acme_airlines_pi/screens/add_task_screen.dart';
import 'package:acme_airlines_pi/screens/completed_tasks_screen.dart';
import 'package:acme_airlines_pi/screens/parts.dart';
import 'package:acme_airlines_pi/screens/my_drawer.dart';
import 'package:acme_airlines_pi/screens/tasks_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({super.key});
  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': TasksScreen(), 'title': 'Tasks'},
    {'pageName': CompletedTasksScreen(), 'title': 'Historico'},
    {'pageName': StorageScreen(), 'title': 'Estoque'},
  ];

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const AddTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[_selectedPageIndex]['title']),
        toolbarHeight: 80,
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0 
      ? FloatingActionButton(
        onPressed: () => _addTask(context),
        tooltip: 'Adicionar task',
        child: const Icon(Icons.add),
      )
      : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
          _selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search),
            label: 'Historico'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Estoque'
          ),
        ],
      ),
    );
  }
}
